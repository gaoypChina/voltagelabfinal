import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voltagelab/Sign_in_Screen/pages/sign_in_page.dart';
import 'package:voltagelab/Sign_in_Screen/pages/sign_up_page.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Color(0xFF8E66FB), Color(0xFF4172F7)],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: <double>[0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75.0),
                
                child: SvgPicture.asset(
                  'images/login.svg',
                  height: 190,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: menubar(context),
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: _pageController,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (int i) {
                    FocusScope.of(context).requestFocus(FocusNode());
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
    );
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
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
