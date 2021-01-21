import 'package:chat_app/model/Users.dart';
import 'package:flutter/material.dart';

class CircularAvatarCreator extends StatelessWidget {
  final int index;
  final List<Users>user;
  final double radius;

  const CircularAvatarCreator({Key key, this.index, this.user, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(user[index].imageLink),
    );
}
}
