
import 'package:flutter/cupertino.dart';

 Widget createButtons(Function validate,String title,Color color,bool isSignUp){


   return    Padding(
     padding: const EdgeInsets.all(10.0),
     child:CupertinoButton(
       child: Text(title) ,
       borderRadius: BorderRadius.circular(10),
       color: color,
       padding: EdgeInsets.symmetric(horizontal: 25, vertical: 11),
       onPressed: ()  {
         validate();

       },),
   );



 }
