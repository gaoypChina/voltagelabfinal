import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voltagelab/widget/Profile_Page_Widget/subscription_widget.dart';

class NewProfilePAge extends StatefulWidget {
  const NewProfilePAge({Key? key}) : super(key: key);

  @override
  _NewProfilePAgeState createState() => _NewProfilePAgeState();
}

class _NewProfilePAgeState extends State<NewProfilePAge> {
  PageController? pageController;
  int selectiteam = 0;

  @override
  void initState() {
    pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        child: Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(top: 50),
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Tanvir Mhamud Shakil",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(top: 5),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: const Text('Product Onwer'),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal: 10, vertical: 20),
                                height: 114,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectiteam = 0;
                                          pageController!.animateToPage(
                                              selectiteam,
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
                                          pageController!.animateToPage(
                                              selectiteam,
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
                                          pageController!.animateToPage(
                                              selectiteam,
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  top: 10,
                  left: 30,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/profilepic2.jpg'),
                    maxRadius: 30,
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
                  const SubscriptionWidgetPage(),
                  Container(
                    color: Colors.red,
                  ),
                  Container(
                    color: Colors.yellow,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
