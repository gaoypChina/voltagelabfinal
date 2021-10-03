import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/signin_provider.dart';

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

  validationchack(BuildContext context) {
    final signin = Provider.of<SignInProvider>(context, listen: false);
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
      signin.fromregistation(fullname!, email, password, context);
    }
  }

  Widget signupform({
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
    Widget? prefixIcon,
    String? hintText,
    Widget? suffixIcon,
    bool? obscureText,
    ValueChanged<String>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
      child: TextFormField(
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16.0, color: Colors.black),
        obscureText: obscureText!,
        decoration: InputDecoration(
          // border: InputBorder.none,
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16.0),
          suffixIcon: suffixIcon,
        ),
      ),
    );
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
    final signin = Provider.of<SignInProvider>(context);
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
                        signupform(
                          onSaved: (newValue) {
                            setState(() {
                              fullname = newValue;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your full name";
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.text,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.user,
                            color: Colors.black,
                          ),
                          hintText: 'Full Name',
                          obscureText: false,
                          suffixIcon: null,
                        ),
                        signupform(
                          onSaved: (newValue) {
                            email = newValue;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your Email Address";
                            } else if (!value.contains('@')) {
                              return "Enter your Valid Email Address";
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.black,
                          ),
                          hintText: 'Email Address',
                          obscureText: false,
                          suffixIcon: null,
                        ),
                        signupform(
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
                          obscureText: _obscureTextPassword,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.black,
                          ),
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
                          hintText: 'Password',
                        ),
                        signupform(
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
                          obscureText: _obscureTextConfirmPassword,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.black,
                          ),
                          hintText: 'Confirmation',
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
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: signin.loading ? 285.0 : 310),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: signin.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          validationchack(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
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
