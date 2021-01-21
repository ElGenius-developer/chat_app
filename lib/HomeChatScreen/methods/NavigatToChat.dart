import 'package:chat_app/Ui/ChatScreen/ChatScreen.dart';
import 'package:flutter/material.dart';

void goToChatScreen(String uid, BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          key: ValueKey('ChatScreen'),
          uid: uid,
        ),
      ));
}
