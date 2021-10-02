import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/Sqflite/Subscription_save_data/Model/subscription_model.dart';
import 'package:voltagelab/Sqflite/Subscription_save_data/db/subscription_one_month.dart';
import 'package:voltagelab/model/Subscription_data_Stream_model/subscription_user_data.dart';

class SubscriptionWidgetPage extends StatefulWidget {
  const SubscriptionWidgetPage({Key? key}) : super(key: key);

  @override
  _SubscriptionWidgetPageState createState() => _SubscriptionWidgetPageState();
}

class _SubscriptionWidgetPageState extends State<SubscriptionWidgetPage> {
  List<Subscriptionsaveuserdata> datalist = [];
  SqlSubscriptiononemonth_DB? sqlSubscriptiononemonth_DB;

  savedata() async {
    datalist = await sqlSubscriptiononemonth_DB!.getdata();
    setState(() {
      
    });
  }

  @override
  void initState() {
    sqlSubscriptiononemonth_DB = SqlSubscriptiononemonth_DB();
     savedata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final payment = Provider.of<PaymentProvider>(context);

    return payment.isloading ? const Center(child: CircularProgressIndicator(),) : Column(
      children: [
        Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: datalist.length,
                  itemBuilder: (context, index) {
                    var data = datalist[index];
                    return Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  "Package name: ${data.subscriptionpack}"),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                              child: Text("Start Date : ${data.startdate}"),
                            ),
                            Container(
                                padding:
                                    EdgeInsets.only(left: 10, bottom: 10),
                                child: Text("End Date : ${data.enddate}")),
                            Container(
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                              child:
                                  Text("remaining : ${data.remaining} day"),
                            ),
                            Container(
                                padding:
                                    EdgeInsets.only(left: 10, bottom: 10),
                                child: Text(
                                    "Status : ${payment.subscriptionuserdata!.status}")),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
      ],
    );
  }
}