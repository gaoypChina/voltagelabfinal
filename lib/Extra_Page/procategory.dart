import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';

class Procategorydata extends StatefulWidget {
  const Procategorydata({Key? key}) : super(key: key);

  @override
  _ProcategorydataState createState() => _ProcategorydataState();
}

class _ProcategorydataState extends State<Procategorydata> {
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).get_pro_bn_vl_categorylist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pro Category"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print(data.pro_bn_vl_categorydatabase.map((e) => e.categoryid).toList());
            },
            child: Text("pro Category"),
          )
        ],
      ),
    );
  }
}
