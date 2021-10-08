import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/Subscription/payment_Iteam_list/payment_iteam.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  bool isloading = false;

  // @override
  // void initState() {
  //   isloading = true;
  //   var box = Hive.box("userdata");
  //   Provider.of<PaymentProvider>(context, listen: false)
  //       .payment_user_info_get(box.get('email'))
  //       .then((value) {
  //     setState(() {
  //       isloading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  void initState() {
    var box = Hive.box("userdata");
    Provider.of<PaymentProvider>(context, listen: false)
        .payment_subscription_one_month_userinfo_get(box.get('email'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final payment = Provider.of<PaymentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
      ),
      body: payment.isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                subscription(
                    color: payment.subscriptionuserdata == null
                        ? Colors.indigo
                        : payment.subscriptionuserdata
                                .any((element) => element.status == "1")
                            ? Colors.indigo.withOpacity(0.5)
                            : Colors.indigo,
                    onTap: payment.subscriptionuserdata == null
                        ? () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const PaymentListPage(
                                    package_price: 100,
                                    subscription_pack_name: 'Basic',
                                    subs_pack_month: 1,
                                  ),
                                ));
                          }
                        : payment.subscriptionuserdata
                                .any((element) => element.status == "1")
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const PaymentListPage(
                                        package_price: 100,
                                        subscription_pack_name: 'Basic',
                                        subs_pack_month: 1,
                                      ),
                                    ));
                              },
                    subs_name: 'Basic',
                    subs_package: '1 month'),
                subscription(
                    color: payment.subscriptionuserdata == null
                        ? Colors.indigo
                        : payment.subscriptionuserdata
                                .any((element) => element.status == "1")
                            ? Colors.indigo.withOpacity(0.5)
                            : Colors.indigo,
                    onTap: payment.subscriptionuserdata == null
                        ? () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const PaymentListPage(
                                    package_price: 100,
                                    subscription_pack_name: 'Advance',
                                    subs_pack_month: 3,
                                  ),
                                ));
                          }
                        : payment.subscriptionuserdata
                                .any((element) => element.status == "1")
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const PaymentListPage(
                                        package_price: 100,
                                        subscription_pack_name: 'Advance',
                                        subs_pack_month: 3,
                                      ),
                                    ));
                              },
                    subs_name: 'Advance',
                    subs_package: '3 month'),
                subscription(
                    color: payment.subscriptionuserdata == null
                        ? Colors.indigo
                        : payment.subscriptionuserdata
                                .any((element) => element.status == "1")
                            ? Colors.indigo.withOpacity(0.5)
                            : Colors.indigo,
                    onTap: payment.subscriptionuserdata == null
                        ? () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const PaymentListPage(
                                    package_price: 100,
                                    subscription_pack_name: 'Custom',
                                    subs_pack_month: 6,
                                  ),
                                ));
                          }
                        : payment.subscriptionuserdata
                                .any((element) => element.status == "1")
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const PaymentListPage(
                                        package_price: 100,
                                        subscription_pack_name: 'Custom',
                                        subs_pack_month: 6,
                                      ),
                                    ));
                              },
                    subs_name: 'Custom',
                    subs_package: '6 month')
              ],
            ),
    );
  }

  Widget subscription(
      {Color? color,
      GestureTapCallback? onTap,
      String? subs_name,
      String? subs_package}) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
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
                      Text(
                        subs_name!,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text('\$24',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          Text('/user',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(subs_package!,
                          style: TextStyle(fontSize: 18, color: Colors.white)))
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
    );
  }
}
