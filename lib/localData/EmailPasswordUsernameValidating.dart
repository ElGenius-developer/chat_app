import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_validator/password_validator.dart';

class EmailAndPasswordValidating {
  PasswordValidator passwordValidator = PasswordValidator(min: 7);
  final fireStore = FirebaseFirestore.instance.collection('users');
  bool isUsernameValid = false;
  bool isPasswordValid = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  ///check is email valid on fireBase
  emailValidation({String value}) {
    if (value.isEmpty)
      return "please Enter username";
    else {
      if (!EmailValidator.validate(value)) return "invalid Email address";

      if (_auth.currentUser != null && _auth.currentUser.email == value)
        isUsernameValid = true;
      else {
        isUsernameValid = false;
      }
    }

    return null;
  }

  ///check is password valid on fireBase*****
  passwordValidating({String value}) {
    if (value.isEmpty)
      return "please Enter the password";
    else if (isUsernameValid == true) {
      return "incorrect password ";
    } else {
      if (!passwordValidator.validate(value)) return "password is too short";
    }

    return null;
  }

  Future checkFirebaseUser(String user) async {
    QuerySnapshot que = await fireStore.get();
    var res = '';
   if(user.trim().isEmpty)
     return 'please enter username';
   else if(user.length<7)
     return "username must be at least 7 letters";
   else{
     for (var doc in que.docs) {
       if (doc.data().values.contains(user)) {
         res = 'username is already registered';
         return res;
       }
     }
   }
    return null;
  }
}
