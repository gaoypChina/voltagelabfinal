import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/connectivity_provider.dart';
import 'package:voltagelab/Sign_in_Screen/pages/sign_in_page.dart';
import 'package:voltagelab/Sign_in_Screen/pages/sign_up_page.dart';
import 'package:voltagelab/pages/Internet_Connectibity/internetdisconnect.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PageController? _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  double positionleft = 0;

  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context, listen: false).startmonitoring();
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ConnectivityProvider>(
      builder: (context, value, child) {
        if (value.isonline != null) {
          return value.isonline!
              ? SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      // color: Colors.white60,
                      gradient: LinearGradient(
                          colors: <Color>[Color(0xFF919CFF), Color(0xFF5066D2)],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 1.0),
                          stops: <double>[0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,

                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/rectagle_white_logo.png',
                            width: 200,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 100.0),
                          // child: SvgPicture.asset(
                          //   'images/login.svg',
                          //   height: 190,
                          // ),
                          //
                          //  Text(
                          //   'স্বাগতম',
                          //   style: GoogleFonts.hindSiliguri(
                          //     color: Colors.black,
                          //     textStyle: Theme.of(context).textTheme.headline4,
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w700,
                          //   ),
                          // ),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: menubar(context),
                          ),
                          Expanded(
                            flex: 2,
                            child: PageView(
                              controller: _pageController,
                              physics: const ClampingScrollPhysics(),
                              onPageChanged: (int i) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (i == 0) {
                                  setState(() {
                                    right = Colors.white;
                                    left = Colors.black;
                                    positionleft = 0;
                                  });
                                } else if (i == 1) {
                                  setState(() {
                                    right = Colors.black;
                                    left = Colors.white;
                                    positionleft = 144;
                                  });
                                }
                              },
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: const SignIn(),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: const SignUp(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const InternetDisconnectpage();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Widget menubar(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: 0,
            bottom: 0,
            left: positionleft,
            child: Container(
              margin: const EdgeInsets.all(3),
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
          Row(
            children: [
              signmenu('লগ ইন', () {
                setState(() {
                  _pageController!.animateToPage(0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                  right = Colors.white;
                  left = Colors.black;
                  positionleft = 0;
                });
              }, left),
              signmenu('রেজিস্ট্রেশন', () {
                setState(() {
                  _pageController!.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                  right = Colors.black;
                  left = Colors.white;
                  positionleft = 144;
                });
              }, right),
            ],
          ),
        ],
      ),
    );
  }

  Widget signmenu(String text, VoidCallback? onPressed, Color? color) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: GoogleFonts.hindSiliguri(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            )),
      ),
    );
  }
}
