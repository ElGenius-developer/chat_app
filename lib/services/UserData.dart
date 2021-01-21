


import 'package:chat_app/model/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData{

  Future<List<Users>> fetchData() async{

  final auth = FirebaseAuth.instance;
  List<Users>users = List();
  final firestore = FirebaseFirestore.instance.collection('users');

  QuerySnapshot snapshot = await firestore.get();
 snapshot.docs.forEach((element) {
      // if(!element.data().containsValue(auth.currentUser.uid))
       users.add(Users.fromJson(element.data()));
 });
return users;


}
  Future<String> getSenderName(String senderId) async{
    String name;
    final firestore = FirebaseFirestore.instance.collection('users');
    QuerySnapshot snapshot = await firestore.get();
    snapshot.docs.forEach((element) {
      if(element.data().containsValue(senderId))
       name=element.data()['firstName'];
    });
return name;

  }




}