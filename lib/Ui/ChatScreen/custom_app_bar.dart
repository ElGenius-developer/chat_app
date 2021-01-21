import 'package:chat_app/Ui/HomeScreen.dart';
import 'package:chat_app/Ui/method_and_widgets_creators/chats/circular_avatar_creator.dart';
import 'package:chat_app/localData/LocalData.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
    final String userId;

  const CustomAppBar({Key key, this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int index =0;
   for(var user in HomeScreen.otherUser )
     {
       if(user.uid==userId)
         {
           index =HomeScreen.otherUser.indexOf(user);
           break;
         }
     }
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: IconButton(
                  color: Colors.white,
                  icon: BackButtonIcon(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 15),
              ),
              Container(
                child: CircularAvatarCreator(
                  radius: 20,
                  index: index,
                  user: HomeScreen.otherUser,
                ),
              ),
            ],
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
               HomeScreen.otherUser[index].firstName,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ],
      ),
      height: 65,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),
    );
  }
}
