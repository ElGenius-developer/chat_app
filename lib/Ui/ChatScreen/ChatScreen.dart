import 'package:chat_app/Ui/ChatScreen/chat_screen_body.dart';
import 'package:chat_app/Ui/ChatScreen/custom_app_bar.dart';
import 'package:chat_app/Ui/ChatScreen/new_message_row.dart';
import 'package:chat_app/localData/LocalData.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String uid;

  const ChatScreen({Key key, this.uid}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: defaultColor,
        body: SafeArea(
            child: Container(
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //custom app bar
                      CustomAppBar(
                        key: ValueKey('CustomerAppBar'),
                        userId: widget.uid,
                      ),
                      //Chat body
                      Expanded(
                          child: ChatScreenBody(receiverUserId: widget.uid)),
                      Container(
                        child: NewMessageRow(
                          userId: widget.uid,
                        ),
                      )
                    ]))));
  }
}
