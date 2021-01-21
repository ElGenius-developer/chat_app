import 'package:chat_app/Ui/HomeScreen.dart';
import 'package:chat_app/Ui/method_and_widgets_creators/chats/circular_avatar_creator.dart';
import 'package:flutter/material.dart';

import 'methods/NavigatToChat.dart';

class HomeChatScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount:
          (HomeScreen.allUsers.isNotEmpty) ? HomeScreen.allUsers.length - 1 : 0,
      itemBuilder: (ctx, index) =>
          //will create widget for this one
          Column(
        children: [
          ListTile(
              title: Text(
                HomeScreen.otherUser[index].firstName +
                    ' ' +
                    HomeScreen.otherUser[index].lastName,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              leading: CircularAvatarCreator(
                index: index,
                radius: 20,
                user: HomeScreen.otherUser,
              ),
              onTap: () {
                HomeScreen.receiverUer = HomeScreen.otherUser[index].uid;
                goToChatScreen(HomeScreen.otherUser[index].uid, context);
              }),
          Container(
            height: 1,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
