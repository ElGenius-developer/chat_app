import 'package:chat_app/model/Messages.dart';
import 'package:chat_app/services/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Utils.dart';

class MessagesService {
  FirebaseAuth auth = FirebaseAuth.instance;

  sendMessage(
      {String senderId,
      String receiverId,
      String message,
      String imageUrl}) async {
    final _fireStoreMessages =
        FirebaseFirestore.instance.collection('messages');
    var hour = Timestamp.now().toDate().hour;
    String name;
    name = await UserData().getSenderName(senderId);

    var amPm = 'am';
    if (hour > 12) {
      hour = hour - 12;
      amPm = 'pm';
    }
    var messages = {
      'message': message,
      'imageUrl': 'test/images',
      'receiverId': receiverId,
      'senderId': senderId,
      'sentAt': (hour == 0)
          ? '0$hour' + ':' + '${Timestamp.now().toDate().minute}'
          : '$hour' + ':' + '${Timestamp.now().toDate().minute}' + ' ' + amPm,
      'time': Timestamp.now(),
      'senderName': name,
      'chatKey': senderId + receiverId
    };

    _fireStoreMessages.add(messages);
  }

  static Stream<List<Messages>> getMessages(
          {String senderId, String receiverId}) =>
      FirebaseFirestore.instance
          .collection('messages')
          .where('senderId', whereIn: [senderId, receiverId])
          .orderBy('time', descending: true)
          .snapshots()
          .transform(Utils.transformer(Messages.fromJson));
}
