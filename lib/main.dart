import 'package:chat_app/localData/LocalData.dart';
import 'package:chat_app/services/LoginServices.dart';
import 'package:chat_app/Ui/AuthenticationWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Ui/AuthenticationWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static LoginServices auth = LoginServices();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.cyan,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          textTheme: TextTheme(caption: TextStyle(color: Colors.white)),
        shadowColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.white
          )
        )
      ),
      home: AuthenticationWidget(),
      // ),
    );
  }
}
