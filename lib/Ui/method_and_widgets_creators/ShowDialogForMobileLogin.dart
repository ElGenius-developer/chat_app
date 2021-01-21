//show alert dialog to allow user input code
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../HomeScreen.dart';

Future sendCode(BuildContext context, verificationId) {
  final _codeController = TextEditingController();
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Give the code?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _codeController,
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: Text("Confirm"),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () async {
                final code = _codeController.text.trim();
                AuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: code);

                UserCredential result = await FirebaseAuth.instance
                    .signInWithCredential(credential);

                User user = result.user;

                if (user != null) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                  //will pass data to home screen

                } else {
                  print("Error");
                }
              },
            )
          ],
        );
      });
}
