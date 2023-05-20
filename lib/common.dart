import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showSnackbar(BuildContext context,String message,bool error){
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 1),
    backgroundColor: error ? Colors.red : Color(0xffff00c3),
    action: SnackBarAction(
      onPressed: () {
        // Some code to undo the change.
      }, label: '',
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget progreess(){
  return LoadingAnimationWidget.discreteCircle(
      color: Color(0xff86106b),
      size: 35,
      secondRingColor: Colors.amber,
      thirdRingColor: Colors.amber);
}