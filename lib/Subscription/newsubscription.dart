import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/Subscription/payment_Iteam_list/payment_iteam.dart';

class NewSubscriptionPage extends StatefulWidget {
  const NewSubscriptionPage({Key? key}) : super(key: key);

  @override
  _NewSubscriptionPageState createState() => _NewSubscriptionPageState();
}

class _NewSubscriptionPageState extends State<NewSubscriptionPage> {
  PageController? _pageController;
  int correntpage = 0;

  // Widget subscription(
  //     {Color? color,
  //     GestureTapCallback? onTap,
  //     String? subs_name,
  //     String? subs_package}) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Container(
  //             margin: const EdgeInsets.all(10),
  //             height: MediaQuery.of(context).size.height * 0.06,
  //             width: MediaQuery.of(context).size.width * 0.13,
  //             decoration: BoxDecoration(
  //                 color: Colors.orange, borderRadius: BorderRadius.circular(5)),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 subs_name!,
  //                 style: TextStyle(fontSize: 18, color: Colors.black),
  //               ),
  //               const SizedBox(
  //                 height: 5,
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: const [
  //                   Text('\$24',
  //                       style: TextStyle(fontSize: 18, color: Colors.black)),
  //                   Text('/user',
  //                       style: TextStyle(fontSize: 14, color: Colors.black)),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           const Spacer(),
  //           Container(
  //               margin: const EdgeInsets.only(right: 10),
  //               child: Text(subs_package!,
  //                   style: TextStyle(fontSize: 18, color: Colors.black)))
  //         ],
  //       ),
  //       Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 10),
  //         child: const Divider(
  //           color: Colors.black,
  //         ),
  //       ),
  //       Container(
  //         margin: const EdgeInsets.all(10),
  //         child: Row(
  //           children: const [
  //             Icon(
  //               Icons.check,
  //               color: Colors.black,
  //               size: 16,
  //             ),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             Text(
  //               'All features in Basic',
  //               style: TextStyle(color: Colors.black),
  //             )
  //           ],
  //         ),
  //       ),
  //       Container(
  //         margin: const EdgeInsets.only(left: 10, right: 10),
  //         child: Row(
  //           children: const [
  //             Icon(
  //               Icons.check,
  //               color: Colors.black,
  //               size: 16,
  //             ),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             Text('Flexible call scheduling',
  //                 style: TextStyle(color: Colors.black))
  //           ],
  //         ),
  //       ),
  //       Container(
  //         margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
  //         child: Row(
  //           children: const [
  //             Icon(
  //               Icons.check,
  //               color: Colors.black,
  //               size: 16,
  //             ),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             Text('15 TB Cloud Storage', style: TextStyle(color: Colors.black))
  //           ],
  //         ),
  //       ),
  //       Flexible(
  //         child: Container(
  //           margin: EdgeInsets.all(10),
  //           child: MaterialButton(
  //             onPressed: () {},
  //             child: Text(
  //               "Choose Plan ->",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //             color: Colors.indigo,
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget aniumationpageview(
      {int? index,
      String? package_name,
      package_month,
      package_prize,
      VoidCallback? buttontab}) {
    final payment = Provider.of<PaymentProvider>(context);
    return AnimatedBuilder(
      animation: _pageController!,
      builder: (context, child) {
        double value = 1;
        if (_pageController!.position.haveDimensions) {
          value = _pageController!.page! - index!;
          value = (1 - (value.abs() * 0.35)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 250,
            width: 600.0,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          // boxShadow: [
          //   BoxShadow(
          //       color: Color(0xFF000000).withOpacity(0.3),
          //       blurRadius: 12.0,
          //       offset: Offset(1.0, 1.0) // darker color
          //       ),
          //   BoxShadow(
          //       color: Color(0xFFFFFFFF).withOpacity(0.5),
          //       blurRadius: 12.0,
          //       offset: Offset(-1.0, -1.0) // darker color
          //       ),
          // ],
        ),
        child: Card(
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
                        package_name!,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('\$$package_prize',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black)),
                          const Text('/user',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(package_month!,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black)))
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Divider(
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Icon(
                      Icons.check,
                      color: Colors.black,
                      size: 16,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'All features in Basic',
                      style: TextStyle(color: Colors.black),
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
                      color: Colors.black,
                      size: 16,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Flexible call scheduling',
                        style: TextStyle(color: Colors.black))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  children: const [
                    Icon(
                      Icons.check,
                      color: Colors.black,
                      size: 16,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('15 TB Cloud Storage',
                        style: TextStyle(color: Colors.black))
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: buttontab,
                    child: const Text(
                      "Choose Plan ->",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    var box = Hive.box("userdata");
    Provider.of<PaymentProvider>(context, listen: false)
        .payment_subscription_one_month_userinfo_get(box.get('email'));
    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 0.8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final payment = Provider.of<PaymentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription"),
      ),
      body: payment.isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    "Flexible Plans",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Choose a plan that works best for you and your team",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[500], fontSize: 18),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: PageView(
                    onPageChanged: (value) {
                      setState(() {
                        correntpage = value;
                      });
                    },
                    controller: _pageController,
                    children: [
                      aniumationpageview(
                        index: 0,
                        package_name: "Basic",
                        package_month: "1 Month",
                        package_prize: 10,
                        buttontab: payment.subscriptionuserdata == null
                            ? () {
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
                      ),
                      aniumationpageview(
                        index: 1,
                        package_name: "Startup",
                        package_month: "3 Month",
                        package_prize: 30,
                        buttontab: payment.subscriptionuserdata == null
                            ? () {
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
                      ),
                      aniumationpageview(
                        index: 2,
                        package_name: "Advance",
                        package_month: "6 Month",
                        package_prize: 60,
                        buttontab: payment.subscriptionuserdata == null
                            ? () {
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
