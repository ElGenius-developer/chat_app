import 'package:chat_app/localData/LocalData.dart';
import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  final bool isMe;
  final String senderName;
  final String message;


  BubbleMessage({Key key, this.isMe, this.senderName, this.message})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        FittedBox(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight:
                      (isMe) ? Radius.circular(0) : Radius.circular(15),
                  bottomLeft:
                      (!isMe) ? Radius.circular(0) : Radius.circular(15),
                ),
                color: (isMe) ? Colors.blueGrey[100] : defaultColor),
            child: //will create widget for this one
                Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                Text(
                  (!isMe)? senderName:'me',
                  style: TextStyle(color:(isMe)?Colors.black: Colors.white,
                      fontWeight:FontWeight.bold ,fontSize: 18),
                ),
                Text(
                  message,
                  style: TextStyle(color:(isMe)?Colors.black: Colors.white,),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
