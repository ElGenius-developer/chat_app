import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  String message;
  String imageUrl;
  String receiverId;
  String senderId;
  String senderName;
  String sentAt;
  Timestamp time;
  String chatKey;

  Messages(
      {this.message,
        this.imageUrl,
        this.receiverId,
        this.senderId,
        this.sentAt,
        this.time,
      this.senderName,
      this.chatKey,
      });

  static Messages fromJson(Map<String, dynamic> json) =>Messages(
    message : json['message'],
    imageUrl : json['imageUrl'],
    receiverId : json['receiverId'],
    senderId : json['senderId'],
    sentAt : json['sentAt'],
    time : json['time'],
    senderName: json['senderName'],
    chatKey: json['chatKey'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['imageUrl'] = this.imageUrl;
    data['receiverId'] = this.receiverId;
    data['senderId'] = this.senderId;
    data['sentAt'] = this.sentAt;
    data['time'] = this.time;
    data['senderName'] = this.senderName;
    data['chatKey']=this.chatKey;
    return data;
  }
}