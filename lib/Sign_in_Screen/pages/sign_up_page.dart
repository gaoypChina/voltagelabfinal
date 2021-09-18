import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeName = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  // TextEditingController signupEmailController = TextEditingController();
  // TextEditingController signupNameController = TextEditingController();
  // TextEditingController signupPasswordController = TextEditingController();
  // TextEditingController signupConfirmPasswordController =
  //     TextEditingController();

  String? fullname, email, password, confirmpassword;

  validationchack() {
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
      print(confirmpassword);
    }
  }

  @override
  void dispose() {
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeEmail.dispose();
    focusNodeName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 330.0,
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            onSaved: (newValue) {
                              fullname = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your full name";
                              }
                            },
                            focusNode: focusNodeName,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            autocorrect: false,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                            decoration: const InputDecoration(
                              // border: InputBorder.none,
                              prefixIcon: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.black,
                              ),
                              hintText: 'Full Name',
                              hintStyle: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            onSaved: (newValue) {
                              email = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Email Address";
                              } else if (!value.contains('@gmail')) {
                                return "Enter your Valid Email Address";
                              }
                            },
                            focusNode: focusNodeEmail,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                              ),
                              hintText: 'Email Address',
                              hintStyle: TextStyle(fontSize: 16.0),
                            ),
                            // onSubmitted: (_) {
                            //   focusNodePassword.requestFocus();
                            // },
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            onSaved: (newValue) {
                              password = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your password";
                              } else if (value.length < 6) {
                                return "Enter minimam 6 digit password";
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            focusNode: focusNodePassword,
                            obscureText: _obscureTextPassword,
                            autocorrect: false,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              hintText: 'Password',
                              hintStyle: const TextStyle(fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignup,
                                child: Icon(
                                  _obscureTextPassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            onSaved: (newValue) {
                              confirmpassword = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Again Password";
                              } else if (value != password) {
                                return "password not match";
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                confirmpassword = value;
                              });
                            },
                            focusNode: focusNodeConfirmPassword,
                            obscureText: _obscureTextConfirmPassword,
                            autocorrect: false,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              // border: InputBorder.none,
                              prefixIcon: const Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              hintText: 'Confirmation',
                              hintStyle: const TextStyle(fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignupConfirm,
                                child: Icon(
                                  _obscureTextConfirmPassword
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            textInputAction: TextInputAction.go,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 310.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0xFFD6D6D6),
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Color(0xFF4153F7),
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: <Color>[Color(0xFFD6D6D6), Color(0xFF4144F7)],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: <double>[0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: const Color(0xFF4441F7),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  onPressed: () {
                    validationchack();
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text('SIGN UP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        )),
                  ),
                  // onPressed: () => _toggleSignUpButton(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // void _toggleSignUpButton() {
  //   CustomSnackBar(context, const Text('SignUp button pressed'));
  // }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }
}
