
import 'package:chat_app/Ui/method_and_widgets_creators/defaultAppBar/createAppBar.dart';
import 'package:chat_app/Ui/method_and_widgets_creators/loginFormComponent/createLoginForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:chat_app/main.dart';

import 'login_with_phone_screen.dart';

class LoginAndCreateScreen extends StatefulWidget {
  @override
  _LoginAndCreateScreenState createState() => _LoginAndCreateScreenState();
}

class _LoginAndCreateScreenState extends State<LoginAndCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(isHome: false),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.42,
                padding: EdgeInsets.all(10),
                child: Card(
                  child: CreateLoginForm(),
                ),
              ),
              SignInButton(
                  buttonType: ButtonType.facebook,
                  onPressed: () async {
                    await MyApp.auth.loginWithFaceBook();
                  }),
              SignInButton(
                  buttonType: ButtonType.google,
                  onPressed: () async {
                    await MyApp.auth.signInWithGoogle();
                  }),
              FilterChip(
                avatar: Icon(
                  Icons.vpn_key,
                  size: 20,
                ),
                padding: EdgeInsets.symmetric(horizontal: 35),
                label: Text("Sign in with phone "),
                onSelected: (value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginWithPhoneScreen(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
