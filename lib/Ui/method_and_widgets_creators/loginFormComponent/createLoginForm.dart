import 'package:chat_app/Ui/method_and_widgets_creators/loginFormComponent/CreateButtons.dart';
import 'package:chat_app/Ui/method_and_widgets_creators/loginFormComponent/CreateNameAndUserFields.dart';
import 'package:chat_app/Ui/method_and_widgets_creators/loginFormComponent/CreateTextFieldInLoginPage.dart';
import 'package:chat_app/Ui/method_and_widgets_creators/loginFormComponent/ShowErrorLine.dart';
import 'package:chat_app/localData/LocalData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';


class CreateLoginForm extends StatefulWidget {
  static TextEditingController username;
  static TextEditingController firstname;
  static TextEditingController lastname;
  @override
  _CreateLoginFormState createState() => _CreateLoginFormState();
}

class _CreateLoginFormState extends State<CreateLoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String error;
  bool resetPassword;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    CreateLoginForm.firstname.dispose();
    CreateLoginForm.username.dispose();
    CreateLoginForm.lastname.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin = true;
    resetPassword = false;
    error = '';
  }

  ///Switch between login and sign up
  Widget signInSignOutWord(String word) {
    return FlatButton(
        onPressed: () {
          _emailController.clear();
          _passwordController.clear();

          setState(() {
            error = null;
            isLogin = !isLogin;
          });
        },
        child: Text(
          word,
          style: TextStyle(color: Colors.blue),
        ));
  }

  @override
  Widget build(BuildContext context) {
    CreateLoginForm.username = TextEditingController();
    CreateLoginForm.firstname = TextEditingController();
    CreateLoginForm.lastname = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CreateNameAndUserFields(), // first name , last name , and username
          CreateTextFieldInLoginPage(
              icon: Icon(
                Icons.email,
              ),
              input: _emailController,
              type: 1),
          CreateTextFieldInLoginPage(
              icon: Icon(
                Icons.vpn_key_rounded,
              ),
              input: _passwordController,
              type: 2),
          Visibility(
            visible: (error != null),
            child: ShowErrorLine(
              email: _emailController.text,
              error: error,
              resetPassword: resetPassword,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: !isLogin,
                  replacement: createButtons(
                      validateSignIn, "Login", Colors.blue[800], false),
                  child: createButtons(
                      validateSignUp, "Sign up", Colors.green[600], true)),
            ],
          ),
          Visibility(
            visible: isLogin,
            replacement: signInSignOutWord("Login"),
            child: signInSignOutWord("Signup"),
          ),
          GestureDetector(
              child: Text(
                "Forget password",
                style: TextStyle(color: Colors.red[900]),
              ),
              onTap: () async {
                await MyApp.auth
                    .resetPassword(email: _emailController.text)
                    .whenComplete(() {
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(
                        "reset link sent .. check your inbox",
                        textScaleFactor: 1.2,
                      ),
                      duration: Duration(seconds: 3),
                    ));
                });
              }),
        ],
      ),
    );
  }

  void validateSignIn() async {
    if (_formKey.currentState.validate()) {
      MyApp.auth
          .signInWithEmailAndPassword(
              _emailController.text, _passwordController.text)
          .then((value) {
        if (value != null) {
          if (value.contains(errors[1])) {
            setState(() {
              error = "email not exist please register";
            });
          } else if (value.contains(errors[2])) {
            setState(() {
              error = "incorrect password";
              resetPassword = true;
            });
          }
        }
      });
    }
  }

  void validateSignUp() async {
    if (_formKey.currentState.validate()) {
      await MyApp.auth
          .signUpWithEmailAndPassword(
              _emailController.text.trim(), _passwordController.text.trim())
          .then((value) {
        if (value != null) {
          if (value.contains(errors[0])) {
            setState(() {
              error = "email is already registered";
            });
          }
        }
        final json = {
          'firstName': CreateLoginForm.firstname.text.trim(),
          'lastName': CreateLoginForm.lastname.text.trim(),
          'uid': FirebaseAuth.instance.currentUser.uid,
          'email': FirebaseAuth.instance.currentUser.email,
          'userName': CreateLoginForm.username.text.trim(),
          'imageLink': 'images/',
        };
        MyApp.auth.addUser(json);

      });
    }
  }
}
