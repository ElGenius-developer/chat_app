import 'package:chat_app/HomeChatScreen/avatars_row.dart';
import 'package:chat_app/HomeChatScreen/home_chat_screen_body.dart';
import 'package:chat_app/localData/LocalData.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/model/Users.dart';
import 'package:chat_app/services/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static List<Users> allUsers = List<Users>();
  static List<Users> otherUser = List<Users>();
  final int loginType;
  static String receiverUer;
  HomeScreen({Key key, this.loginType}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => MyApp.auth.auth.signOut())
        ],
        elevation: 0,
        toolbarHeight: 55,
        title: Text(
          "ChatApp",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: defaultColor,
      ),

      //*******//      body        ////////
      backgroundColor: defaultColor,
      body: FutureBuilder(
          future: UserData().fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              HomeScreen.allUsers = snapshot.data;
              return Column(
                children: [
                  //Avatars of users
                  Container(height: 65, child: AvatarsRow()),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: HomeChatScreenBody(),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
