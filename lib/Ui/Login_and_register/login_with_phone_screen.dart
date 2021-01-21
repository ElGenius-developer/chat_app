import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';

class LoginWithPhoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login With phone"),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Mobile Number"),
                controller: _phoneController,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("LOGIN"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () async {
                    final phone = _phoneController.text.trim();

                    await MyApp.auth
                        .loginWithMobile(context: context, mobileNumber: phone);
                  },
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
