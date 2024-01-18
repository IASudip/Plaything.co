// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  final UsersClass? users;

  Users({
    this.users,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        users:
            json["users"] == null ? null : UsersClass.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "users": users?.toJson(),
      };
}

class UsersClass {
  final String? avatar;
  final String? code;
  final String? documentId;
  final String? userId;
  final DateTime? createdAt;
  final List<Chat>? chats;

  UsersClass({
    this.avatar,
    this.code,
    this.documentId,
    this.userId,
    this.createdAt,
    this.chats,
  });

  factory UsersClass.fromJson(Map<String, dynamic> json) => UsersClass(
        avatar: json["avatar"],
        code: json["code"],
        documentId: json["document_id"],
        userId: json["user_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        chats: json["chats"] == null
            ? []
            : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "code": code,
        "document_id": documentId,
        "user_id": userId,
        "createdAt": createdAt?.toIso8601String(),
        "chats": chats == null
            ? []
            : List<dynamic>.from(chats!.map((x) => x.toJson())),
      };
}

class Chat {
  final String? documentId;
  final String? userId;
  final String? userName;
  final String? status;

  Chat({
    this.documentId,
    this.userId,
    this.userName,
    this.status,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        documentId: json["document_id"],
        userId: json["userId"],
        userName: json["user_name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "document_id": documentId,
        "userId": userId,
        "user_name": userName,
        "status": status,
      };
}
