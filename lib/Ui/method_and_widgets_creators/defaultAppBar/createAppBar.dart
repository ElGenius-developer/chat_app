import 'package:chat_app/localData/LocalData.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';

Widget createAppBar({String title, bool isHome, BuildContext context}) {
  if (title == null) {
    if (isHome)
      title = 'Home';
    else
      title = 'Signing';
  }
  return AppBar(
    backgroundColor: defaultColor,
    elevation: 0,
    title: Text(title), //(isHome == false&&title==null) ? "Signing" : "Home"
    automaticallyImplyLeading: false,
    actions: [
      if (isHome == true)
        FlatButton.icon(
            label: Text(
              "logout",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
// color: Colors.white,
            onPressed: () {
              MyApp.auth.signOut();
            })
      else
        Container(),
    ],
  );
}
