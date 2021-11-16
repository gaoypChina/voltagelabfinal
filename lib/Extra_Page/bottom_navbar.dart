import 'package:flutter/material.dart';
import 'package:voltagelab/Screen/Voltage_Lab/MCQ/mcq_categorylist.dart';
import 'package:voltagelab/pages/homepage.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   color: Colors.red,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       // Flexible(
            //       //     child: Icon(
            //       //   Icons.ac_unit,
            //       //   size: 40,
            //       // )),
            //       // Text("Test")
            //     // ],
            //   ),
            // ),
            // Column(
            //   children: [
            //     Flexible(
            //         child: Icon(
            //       Icons.ac_unit,
            //       size: 40,
            //     )),
            //     Text("Test")
            //   ],
            // ),
            // Column(
            //   children: [
            //     Flexible(
            //         child: Icon(
            //       Icons.ac_unit,
            //       size: 40,
            //     )),
            //     Text("Test")
            //   ],
            // ),
            // Column(
            //   children: [
            //     Flexible(
            //         child: Icon(
            //       Icons.ac_unit,
            //       size: 40,
            //     )),
            //     Text("Test")
            //   ],
            // ),
            tapNewPage(
              icon: Icon(Icons.ac_unit),
              names: "test",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
            ),
            tapNewPage(
              icon: Icon(Icons.ac_unit),
              names: "test",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const McqCategoryList(),
                    ));
              },
            ),
            tapNewPage(icon: Icon(Icons.ac_unit), names: "test"),
            tapNewPage(icon: Icon(Icons.ac_unit), names: "test")
          ],
        ));
  }

  Widget tapNewPage({
    Icon? icon,
    String? names,
    GestureTapCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Flexible(
            child: icon!,
          ),
          Text(names.toString())
        ],
      ),
    );
  }
}
