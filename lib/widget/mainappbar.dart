
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MainAppbar extends StatelessWidget {
  String appBar;
  MainAppbar({Key? key,required this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Title",style: TextStyle(color: Colors.white),),
          Text("SEcond", style: TextStyle(color: Colors.blue),)
        ],
      )
    );
  }
}
