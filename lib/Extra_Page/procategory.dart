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
    Provider.of<CategoryProvider>(context, listen: false).getpro_bvangla_voltagelabcategorylist();
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
              print(data.probanglavoltagelabcategorydatabaselist.map((e) => e.categoryid).toList());
            },
            child: Text("pro Category"),
          )
        ],
      ),
    );
  }
}
