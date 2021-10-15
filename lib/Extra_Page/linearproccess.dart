import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/otherprovider.dart';

class TextSizeControll extends StatefulWidget {
  const TextSizeControll({Key? key}) : super(key: key);

  @override
  _TextSizeControllState createState() => _TextSizeControllState();
}

class _TextSizeControllState extends State<TextSizeControll> {

  @override
  Widget build(BuildContext context) {
    final textsize = Provider.of<Otherprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextSize"),
      ),
      body: Column(
        children: [
          Slider(
            value: textsize.textsize,
            onChanged: (value) {
              textsize.textsizecontroll(value);
            },
            min: 1.0,
            max: 100.0,
          ),
          Container(
            child: Text(
              "Text Size",
              style: TextStyle(fontSize: textsize.textsize),
            ),
          )
        ],
      ),
    );
  }
}
