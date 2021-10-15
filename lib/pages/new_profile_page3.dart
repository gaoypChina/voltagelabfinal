import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/widget/Profile_Page_Widget/subscription_widget.dart';

class NewProfilePage3 extends StatefulWidget {
  const NewProfilePage3({Key? key}) : super(key: key);

  @override
  _NewProfilePage3State createState() => _NewProfilePage3State();
}

class _NewProfilePage3State extends State<NewProfilePage3> {
  PageController? pageController;
  int selectiteam = 0;

  @override
  void initState() {
    var box = Hive.box("userdata");
    Provider.of<PaymentProvider>(context, listen: false)
        .payment_subscription_one_month_userinfo_get(box.get('email'));
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userdata");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06,
                    left: 5,
                    right: 5),
                // height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05,
                            left: 10),
                        child: Text(box.get('name')),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 10),
                        child: Text(box.get('email')),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectiteam = 0;
                                  pageController!.animateToPage(selectiteam,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOutCubic);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: const Text('Summay'),
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      color: selectiteam == 0
                                          ? Colors.indigo
                                          : Colors.transparent),
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectiteam = 1;
                                  pageController!.animateToPage(selectiteam,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOutCubic);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: const Text('Subscription'),
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      color: selectiteam == 1
                                          ? Colors.indigo
                                          : Colors.transparent),
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectiteam = 2;
                                  pageController!.animateToPage(selectiteam,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOutCubic);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: const Text('Product purchase'),
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      color: selectiteam == 2
                                          ? Colors.indigo
                                          : Colors.transparent),
                                )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.04,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(100),
                  borderOnForeground: true,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.indigo,
                        border: Border.all(color: const Color(0xFFE0E0E0))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'images/profilepic2.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Flexible(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  selectiteam = value;
                });
              },
              children: const [
                SubscriptionWidgetPage(),
                SubscriptionWidgetPage(),
                Center(
                  child: Text('Comming Soon'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
