import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/Sqflite/Subscription_save_data/Model/subscription_model.dart';
import 'package:voltagelab/Sqflite/Subscription_save_data/db/subscription_one_month.dart';
import 'package:voltagelab/model/Subscription_data_Stream_model/subscription_all_data.dart';

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
    setState(() {});
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

    return payment.isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: datalist.length,
                  itemBuilder: (context, index) {
                    var data = datalist[index];
                    if (datalist.isEmpty) {
                      return const Center(
                        child: Text("No Activity",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            )),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                    "Package name: ${data.subscriptionpack}", style: GoogleFonts.lato(),),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: Text("Start Date : ${data.startdate}", style: GoogleFonts.lato()),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 10),
                                  child: Text("End Date : ${data.enddate}", style: GoogleFonts.lato())),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child:
                                    Text("Remaining : ${data.remaining} day", style: GoogleFonts.lato()),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 10),
                                  child: data.status == '0'
                                      ?  Text("Status : Pending", style: GoogleFonts.lato())
                                      : data.status == '1'
                                          ?  Text("Status : Approved", style: GoogleFonts.lato())
                                          : data.status == '2'
                                              ? Text("Status : Expired", style: GoogleFonts.lato())
                                              : Text("Status : Pending", style: GoogleFonts.lato())),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          );
  }
}
