import 'package:chat_app/Ui/HomeScreen.dart';
import 'package:chat_app/Ui/method_and_widgets_creators/chats/circular_avatar_creator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'methods/NavigatToChat.dart';

class AvatarsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: HomeScreen.allUsers.length-1,
        itemBuilder: (context, index) {
          HomeScreen.allUsers.map((user){
            if(user.uid!=FirebaseAuth.instance.currentUser.uid)
            {
              HomeScreen.otherUser.add(user);
            }
          }).toList();
          return  Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 5),
            child: GestureDetector(
                onTap: () => goToChatScreen(HomeScreen.otherUser[index].uid,context),
                child: CircularAvatarCreator(
                  key: ValueKey("avatar"),
                  index: index,
                  radius: 28,
                  user:HomeScreen. otherUser,
                )),
          );
        }
    );
  }
}
