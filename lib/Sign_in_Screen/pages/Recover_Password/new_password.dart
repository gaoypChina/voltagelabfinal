import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/signin_provider.dart';

class NewPasswordPage extends StatefulWidget {
  final String email;
  const NewPasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formkey = GlobalKey<FormState>();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  String? newpassword, confirmpassword;

  validationchack(BuildContext context) {
    final signin = Provider.of<SignInProvider>(context, listen: false);
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
      signin.userpassswordupdate(widget.email, 2, confirmpassword!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signin = Provider.of<SignInProvider>(context);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "New Password",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Card(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: 300,
                  child: Column(
                    children: [
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 0.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                onSaved: (newValue) {
                                  newpassword = newValue;
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
                                    newpassword = value;
                                  });
                                },
                                obscureText: _obscureTextPassword,
                                autocorrect: false,
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 0.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                onSaved: (newValue) {
                                  confirmpassword = newValue;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Again Password";
                                  } else if (value != newpassword) {
                                    return "password not match";
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    confirmpassword = value;
                                  });
                                },
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
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            validationchack(context);
                          },
                          child: const Text("Verify"))
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   flex: 2,
              //   child: Container(),
              // ),
            ],
          ),
        ),
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
