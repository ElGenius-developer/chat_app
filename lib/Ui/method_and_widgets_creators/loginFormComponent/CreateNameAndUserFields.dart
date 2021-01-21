import 'package:chat_app/localData/EmailPasswordUsernameValidating.dart';
import 'package:chat_app/localData/LocalData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'createLoginForm.dart';

class CreateNameAndUserFields extends StatefulWidget {
  @override
  _CreateNameAndUserFieldsState createState() =>
      _CreateNameAndUserFieldsState();
}

class _CreateNameAndUserFieldsState extends State<CreateNameAndUserFields> {
  Widget _createTextField(
      {String word,
      TextEditingController controller,
      Function validation,
      bool isUserName}) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5),
      height: 60,
      width: (isUserName) ? width : width / 2.4,
      child: TextFormField(
        validator: (value) => isUserName
            ? validation(value)
            : value.trim().isNotEmpty
                ? null
                : "Enter $word",
        controller: controller,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            fillColor: defaultColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            prefixIcon: Icon(Icons.person),
            hintText: word),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: !isLogin,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _createTextField(
                  controller: CreateLoginForm.firstname,
                  word: "First name",
                  isUserName: false,
                ),
                _createTextField(
                  controller: CreateLoginForm.lastname,
                  word: "Last name",
                  isUserName: false,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(5),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                validator: (value) {
                  String result;
                  EmailAndPasswordValidating()
                      .checkFirebaseUser(value)
                      .then((res) {
                    if (res == null) {
                      setState(() {});
                    } else {
                      setState(() {
                        result = 'user is registered';
                      });
                    }
                  });
                  return result;
                },
                controller: CreateLoginForm.username,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: defaultColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    prefixIcon: Icon(Icons.person),
                    hintText: "Username"),
              ),
            ),
          ],
        ));
  }
}
