import 'package:flutter/material.dart';
import 'package:chat_app/main.dart';

//this class used to display error message on login
class ShowErrorLine extends StatelessWidget {
  final String error, email;
  final resetPassword;
  const ShowErrorLine({Key key, this.error, this.resetPassword, this.email})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 17,
              child: Text(
                error,
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
          //Error message line and reset function
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Visibility(
              visible: resetPassword,
              child: Column(
                children: [
                  GestureDetector(
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.red[900]),
                      ),
                      onTap: () async {
                        await MyApp.auth
                            .resetPassword(email: email)
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
                  Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red[900],
                    height: 1,
                    width: 35,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
