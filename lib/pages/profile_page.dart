import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/signin_provider.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signin = Provider.of<SignInProvider>(context);
    var box = Hive.box("userdata");

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Material(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child:box.get('photo')=="" ? Image.asset('images/img5.png') : Image.network(
                                  box.get('photo'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            box.get('name'),
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Account Details",
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Text('Edit')
                            ],
                          ),
                          const Divider()
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Full Name'),
                          const SizedBox(height: 2),
                          Text(box.get('name'),
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 20),
                          const Text('Email'),
                          const SizedBox(height: 2),
                          Text(box.get('email'),
                              style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 20),
                          // const Text('Id'),
                          const SizedBox(height: 2),
                          // Text(box.get('id'),
                          //     style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
