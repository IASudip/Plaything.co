import 'dart:math';
import 'package:flutter/material.dart';
import 'package:plaything/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plaything/core/utlis/shared_pref.dart';
import 'package:plaything/models/user_model.dart';
import 'package:plaything/widgets/dialogs/share_dialog.dart';
import 'package:plaything/widgets/modals/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectUserController extends GetxController {
  final Users users = Users();
  TextEditingController codeController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxInt code = 0.obs;
  RxString status = 'unverified'.obs;
  RxString userID = ''.obs;
  String? prefUserId = '';
  String? prefDocId = '';
  RxBool creatingUser = false.obs;
  RxBool authSharedCode = false.obs;
  DocumentReference? chatDocRef;

  Future<void> chatList() async {
    CollectionReference collectionReference = _firestore.collection('users');
    DocumentSnapshot chatList = await collectionReference.doc(prefDocId).get();
    debugPrint("---->>>Chat List: $chatList<<<----");
  }

  Future<void> sendAccessRequest() async {
    authSharedCode.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? prefDocID = preferences.getString(PrefString.docID);

    if (prefDocID == null) {
      await _createUser();
      bool checkCode = await verifyAuthencationCode();

      if (checkCode) {
        await checkUserEverConnected();
      }
    } else {
      bool checkCode = await verifyAuthencationCode();
      if (checkCode) {
        await checkUserEverConnected();
      }
    }
  }

  Future<void> checkUserEverConnected() async {
    debugPrint("Send Notifcation for access");
  }

  Future<bool> verifyAuthencationCode() async {
    CollectionReference collectionReference = _firestore.collection("users");
    QuerySnapshot checkCode = await collectionReference
        .where('code', isEqualTo: codeController.value.text)
        .get();

    bool isCodeExist = checkCode.docs.isNotEmpty;
    if (isCodeExist) {
      String senderID = checkCode.docs.first['user_id'];
      String documentRefID = checkCode.docs.first['document_id'];

      Users users = Users(
        users: UsersClass(chats: [
          Chat(
            toUser: senderID,
            status: "verified",
          ),
        ]),
      );
      chatDocRef =
          await collectionReference.doc(prefDocId).collection('chat').add({
        'toUser': users.users!.chats!.first.toUser,
        'status': users.users!.chats!.first.status,
      });
      await collectionReference
          .doc(prefDocId)
          .collection('chat')
          .doc(chatDocRef!.id)
          .update({'document_id': chatDocRef!.id});

      Users users2 = Users(
        users: UsersClass(chats: [
          Chat(
            fromUser: prefUserId,
            status: "verified",
          ),
        ]),
      );
      DocumentReference chatDocRef2 =
          await collectionReference.doc(documentRefID).collection('chat').add({
        'fromUser': users2.users!.chats!.first.fromUser,
        'status': users2.users!.chats!.first.status,
      });
      await collectionReference
          .doc(documentRefID)
          .collection('chat')
          .doc(chatDocRef2.id)
          .update({'document_id': chatDocRef2.id}).whenComplete(
              () => authSharedCode.value = false);
      // var statusQuerySnapshot = collectionReference
      //     .doc(documentRefID)
      //     .collection('chat')
      //     .snapshots()
      //     .listen((event) {
      //   status.value = event.docs.first.id;
      // });

      codeController.clear();
      Get.back();
    } else {
      debugPrint("Code doesn't match.");
    }
    return isCodeExist;
  }

  Future<void> saveUser() async {
    CollectionReference collectionReference = _firestore.collection("users");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? prefDocID = preferences.getString(PrefString.docID);
    creatingUser.value = true;

    if (prefDocID == null) {
      await _createUser();
    } else {
      prefDocId = preferences.getString(PrefString.docID);
      code.value = await _authorizationCode();
      Users users = Users(
        users: UsersClass(
          code: code.toString(),
        ),
      );
      collectionReference
          .doc(prefDocId)
          .update({'code': users.users?.code}).whenComplete(
              () => creatingUser.value = false);
    }
  }

  Future<void> _createUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userID.value = await _getUserID();
    code.value = await _authorizationCode();

    Users users = Users(
      users: UsersClass(
        userId: userID.value,
        code: code.toString(),
        createdAt: DateTime.now(),
      ),
    );
    DocumentReference documentReference =
        await _firestore.collection('users').add(({
              'code': users.users!.code,
              'user_id': users.users!.userId,
              'createdAt': users.users!.createdAt,
            }));
    await preferences.setString(PrefString.userID, userID.value);
    await preferences.setString(PrefString.docID, documentReference.id);
    prefUserId = preferences.getString(PrefString.userID);
    prefDocId = preferences.getString(PrefString.docID)!;

    await documentReference.update({'document_id': prefDocId}).whenComplete(
        () => creatingUser.value = false);
  }

  Future<int> _authorizationCode() async {
    QuerySnapshot checkCode = await _firestore
        .collection('users')
        .where('code', isEqualTo: code.value)
        .get();
    bool isCodeExisting = checkCode.docs.isNotEmpty;
    while (isCodeExisting) {
      _generateUniqueCode();
    }
    return _generateUniqueCode();
  }

  int _generateUniqueCode() {
    int genrateCode = 000000;
    Random random = Random();
    genrateCode = random.nextInt(888888) + 111111;
    return genrateCode;
  }

  Future<String> _getUserID() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: userID.value)
        .get();
    bool check = querySnapshot.docs.isNotEmpty;
    while (check) {
      _generateUniqueID();
    }
    return _generateUniqueID();
  }

  String _generateUniqueID() {
    String characters =
        '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String uniqueId = '';

    for (int i = 0; i < 16; i++) {
      uniqueId += characters[Random().nextInt(characters.length)];
    }
    return uniqueId;
  }

  void showShareSheet() {
    Get.bottomSheet(
      ShareModalSheet(),
      backgroundColor: appTheme.gray400,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
    );
    return;
  }

  void showConnetSheet() {
    Get.bottomSheet(
      const ConnectModalSheet(),
      backgroundColor: appTheme.gray400,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
    );
    return;
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }
}
