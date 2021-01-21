import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chat_app/Ui/method_and_widgets_creators/ShowDialogForMobileLogin.dart';
import 'package:chat_app/localData/LocalData.dart';

class LoginServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  var _error;
  final GoogleSignIn _googleSigning = GoogleSignIn();
  final FacebookLogin _fb = FacebookLogin();
  final fireService = FirebaseFirestore.instance.collection('users');

//sign in into firebase as guest
  Future signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e);
      return null;
    }
  }

  //Create New Note
  void addUser(Map<String, dynamic> json) {
    try {
      fireService.add(json);
    } catch (e) {
      _error = e;
      print(e);
    }
  }

  // login with facebook account this will create a pop up dialog to login then assign data to firebasse
  Future loginWithFaceBook() async {
// Log in
    FacebookLoginResult res = await _fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
      FacebookPermission.userPhotos,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        print("success ");

        //Hold Token that we got from fb
        final FacebookAccessToken fbToken = res.accessToken;

        //Convert Token to Auth Credential to use it for fire base sign in
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(fbToken.token);

        //User Credential to log in
        try {
          await auth.signInWithCredential(authCredential);
        } catch (e) {
          // print(e.message);
          _error = e.message;
          return _error;
        }

        break;
      //user cancel login
      case FacebookLoginStatus.cancel:
        _error = "user cancel login ";
        print("canceled ");
        break;
      //error login
      case FacebookLoginStatus.error:
        _error = "Error login on facebook";
        print("error");
        break;
      //create scaffold key two inform user with error if you want ///

    }
  }

  //take mobile and login in firebase after sending code and run recpatcha
  Future loginWithMobile({String mobileNumber, BuildContext context}) async {
    var _error;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          _error = error;
        },
        codeSent: (verificationId, forceResendingToken) {
          sendCode(context, verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {/*print(verificationId);*/},
      );
      return true;
    } catch (e) {
      print(e);
    }
    return _error;
  }

// take email and password from user then sign in into firebase
  Future signUpWithEmailAndPassword(String email, String password) async {
    var error;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      errors.forEach((element) {
        if (e.message.contains(element)) error = element;
      });
    }
    return error;
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSigning.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential);

      //print("\n\n\n\nlogin in success\n\n\n\n");
    } catch (e) {
      // print("\n\n\n\n\nerror\n\n\n\n");
    }
    return null;
  }

//sign out from google account  and firebase
  Future<void> signOutGoogle() async {
    await _googleSigning.signOut();
    await auth.signOut();

    print("User Signed Out");
  }

  // reset password , will send a link to email to reset password
  Future resetPassword({String email}) async {
    var error;
    try {
      await auth.sendPasswordResetEmail(email: email);
      error = null; //true
    } catch (e) {
      errors.forEach((element) {
        if (e.message.contains(element)) error = element;
      });
    }
    return error;
  }

  // signout from firebase
  Future<bool> signOut() async {
    try {
      await auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

//log in with an existing email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    var error;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      errors.forEach((element) {
        if (e.message.contains(element)) {
          error = element;
          print(e.message);
        }
      });
      //false
    }
    return error;
  }
}
