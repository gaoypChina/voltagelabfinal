import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/google_signin_provider.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final signin = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "Sign in with Google",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(
                  width: 270,
                  child: Card(
                    color: Colors.blueAccent,
                    child: InkWell(
                      onTap: () {
                        signin.signInWithGoogle();
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Image.asset(
                              'images/google.png',
                              height: 27,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Sign in with Google',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 280,
                  child: Card(
                    color: Colors.blueAccent,
                    child: InkWell(
                      onTap: () {
                        // FacebookAuth.instance.webInitialize(
                        //   appId: "1194407561081411",
                        //   cookie: true,
                        //   xfbml: true,
                        //   version: "v11.0",
                        // );
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Image.asset(
                              'images/google.png',
                              height: 27,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              'Sign in with Facebook',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
