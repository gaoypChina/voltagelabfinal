import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voltagelab/Subscription/userinformation.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SubsUSerInformation(),
                      ));
                },
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.13,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Startup',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('\$24',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                Text('/user',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Text('1 mounth',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)))
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Divider(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'All features in Basic',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Flexible call scheduling',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
