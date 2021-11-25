import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/Provider/signin_provider.dart';
import 'package:voltagelab/helper/global.dart';
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
    final signin = Provider.of<SignInProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: Global.enPostListAppbarText,
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
                        child: Text(
                          box.get('name'),
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            child: Text(box.get('email'),
                                style: GoogleFonts.lato()),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child:InkWell(onTap: () {
                              signin.logout(context);
                            } ,child: Text("Log Out", style: GoogleFonts.lato(),),),
                          )
                        ],
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10),
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
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
                                  child: Text(
                                    'Summay',
                                    style: GoogleFonts.lato(fontSize: 16),
                                  ),
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
                                  child: Text('Subscription',
                                      style: GoogleFonts.lato(fontSize: 16)),
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                        color: selectiteam == 1
                                            ? Colors.indigo
                                            : Colors.transparent),
                                  )),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
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
                                    child: Text('Product purchase',
                                        style: GoogleFonts.lato(fontSize: 16),
                                        overflow: TextOverflow.ellipsis),
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                          color: selectiteam == 2
                                              ? Colors.indigo
                                              : Colors.transparent),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      // color: Colors.indigo,
                      // border: Border.all(color: const Color(0xFFE0E0E0))
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'images/man.png',
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
              children: [
                SubscriptionWidgetPage(),
                SubscriptionWidgetPage(),
                Center(
                  child: Text(
                    'Comming Soon',
                    style: GoogleFonts.lato(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
