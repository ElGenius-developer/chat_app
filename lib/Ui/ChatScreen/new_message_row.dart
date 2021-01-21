
import 'package:chat_app/localData/LocalData.dart';
import 'package:chat_app/model/Users.dart';
import 'package:chat_app/services/MessagesService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ChatScreen.dart';

class NewMessageRow extends StatefulWidget {
  final String userId;


    NewMessageRow({Key key, this.userId}) : super(key: key);

  @override
  _NewMessageRowState createState() => _NewMessageRowState();
}

class _NewMessageRowState extends State<NewMessageRow> {
String _newMessage='';
static TextEditingController messageController;



  _sendMessage()  {
    FocusScope.of(context).unfocus();
      MessagesService().sendMessage(
        senderId: FirebaseAuth.instance.currentUser.uid,
        receiverId: widget.userId,
        imageUrl: '',
        message: _newMessage);
      messageController.clear();
  }
@override
  void initState() {
    super.initState();
    messageController=TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
  messageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(

          child: TextField(
              controller: messageController,
              maxLines: 1000,
              minLines: 1,
              onChanged: (value) {
                setState(() {
                  _newMessage=value;
                });

              },
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(

                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(25)),
                hintText: "Enter a message...",

              )),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () =>
          (messageController.text.isNotEmpty)
              ? _sendMessage()
              : null,
          child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius:
                  BorderRadius.circular(70)),
              child: Icon(
                Icons.send_rounded,
                color: _newMessage.isEmpty?Colors.black26:
                defaultColor,
                size: 30,
              )),
        ),
      ],
    );
  }
}
