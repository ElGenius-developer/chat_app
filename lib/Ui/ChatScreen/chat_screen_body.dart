import 'package:chat_app/Ui/ChatScreen/bubble_message.dart';
import 'package:chat_app/model/Messages.dart';
import 'package:chat_app/services/MessagesService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreenBody extends StatelessWidget {
  final String receiverUserId;

  const ChatScreenBody({Key key, this.receiverUserId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
        stream: MessagesService.getMessages(
          senderId: currentUser.uid,
          receiverId: receiverUserId,
        ),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Messages> _messages = snapShot.data;

            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemCount: (_messages.isEmpty) ? 0 : _messages.length,
                itemBuilder: (ctx, index) {
                  return BubbleMessage(
                      message: _messages[index].message,
                      isMe: (_messages[index].senderId == currentUser.uid),
                      senderName: _messages[index].senderName);
                });
          }
        });
  }
}
