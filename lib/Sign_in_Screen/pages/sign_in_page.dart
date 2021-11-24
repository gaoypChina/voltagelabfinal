import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/signin_provider.dart';
import 'package:voltagelab/Sign_in_Screen/pages/Recover_Password/recovery_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  bool _obscureTextPassword = true;

  String? email, password;

  validationchack(BuildContext context) {
    final signin = Provider.of<SignInProvider>(context, listen: false);
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
      signin.fromlogin(email!, password, context);
    }
  }

  Widget signinform(
      {FormFieldSetter<String>? onSaved,
      FormFieldValidator<String>? validator,
      TextInputType? keyboardType,
      Widget? prefixIcon,
      String? hintText,
      Widget? suffixIcon,
      bool? obscureText}) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        obscureText: obscureText!,
        // controller: loginEmailController,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16.0, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: GoogleFonts.hindSiliguri(fontSize: 17.0),
        ),
      ),
    );
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signin = Provider.of<SignInProvider>(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 23.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: SizedBox(
                    width: 300.0,
                    height: 200.0,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          signinform(
                              hintText: 'ইমেইল এড্রেস',
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (newValue) {
                                setState(() {
                                  email = newValue;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "ইমেইল এড্রেস দিন";
                                } else if (!value.contains('@')) {
                                  return "সঠিক ইমেইল এড্রেস দিন!!!";
                                }
                              },
                              prefixIcon: const Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              suffixIcon: null,
                              obscureText: false),
                          signinform(
                            hintText: 'পাসওয়ার্ড',
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) {
                              setState(() {
                                password = newValue;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "পাসওয়ার্ড দিন";
                              } else if (value.length < 6) {
                                return "৬ ডিজিটের পাসওয়ার্ড দিন";
                              }
                            },
                            prefixIcon: const Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                            obscureText: _obscureTextPassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 180.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: ElevatedButton(
                          onPressed: () {                            
                            validationchack(context);
                          },
                          child:  Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 42.0),
                            child: Text(
                              'লগইন',
                              style: GoogleFonts.hindSiliguri(fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          )),
                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     validationchack(context);
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 10.0, horizontal: 42.0),
                  //     child: signin.loading
                  //         ? Container(
                  //             height: MediaQuery.of(context).size.height * 0.04,
                  //             width: 50,
                  //             child: const Center(
                  //               child: CircularProgressIndicator(),
                  //             ),
                  //           )
                  //         : const Text(
                  //             'Login',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 25.0,
                  //             ),
                  //           ),
                  //   ),
                  //   // onPressed: () => CustomSnackBar(
                  //   //     context, const Text('Login button pressed')),
                  // ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecoveryPasswordPage(),
                        ));
                  },
                  child:  Text(
                    'পাসওয়ার্ড ভুলে গিয়েছেন?',
                    style: GoogleFonts.hindSiliguri(color: Colors.white,
                      fontSize: 16.0)
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.white10,
                            Colors.white,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 1.0),
                          stops: <double>[0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      'অথবা',
                      style: GoogleFonts.hindSiliguri(color: Colors.white,
                        fontSize: 16.0,)
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white10,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 1.0),
                          stops: <double>[0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0, right: 40.0),
                //   child: GestureDetector(
                //     onTap: () async {
                //      signin.facebooklogin().then((value) {
                //             FacebookAuth.getInstance()
                //                 .getUserData()
                //                 .then((userdata) {
                //               setState(() {
                //                 print(userdata);
                //               });
                //             });
                //           });
                //     },
                //     child: Container(
                //       padding: const EdgeInsets.all(15.0),
                //       decoration: const BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: Colors.white,
                //       ),
                //       child: const Icon(
                //         FontAwesomeIcons.facebookF,
                //         color: Color(0xFF0084ff),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      signin.signInWithGoogle(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.google,
                        color: Color(0xFF0084ff),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}
