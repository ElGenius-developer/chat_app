import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/Ui/Login_and_register/LoginAndCreateScreen.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class AuthenticationWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return LoginAndCreateScreen();
        } else {

          return HomeScreen(


          );
        }
      },
    );
  }
}
