import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:voltagelab/Sign_in_Screen/login.dart';
import 'package:voltagelab/helper/global.dart';
import 'package:voltagelab/pages/Guest/guest_home_init_page.dart';

class GuestPop extends StatefulWidget {
  const GuestPop({Key? key}) : super(key: key);

  @override
  _GuestPopState createState() => _GuestPopState();
}

class _GuestPopState extends State<GuestPop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: Text(
          "লগিন এলার্ট",
          style: GoogleFonts.hindSiliguri(
              color: Colors.red.shade300,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        content: Text(
            "এই ফিচারটি শুধুমাত্র লগিন ইউজার দের জন্য। লগিন / রেজিস্ট্রেশন করতে চাইলে নিচের Login বাটনে ক্লিক করুন।",
            style: Global.bnAlertText),
        actions: <Widget>[
          Row(
            children: [
              DialogButton(
                width: 80,
                color: Colors.white,
                child: Text("Login",
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Global.defaultColor,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () async {
                  Navigator.pop(context);
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
              ),
              DialogButton(
                  width: 50,
                  color: Colors.white,
                  child: Text("Close",
                      style: GoogleFonts.lato(
                        color: Colors.red.shade300,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () => Navigator.pushReplacement(
                    context,MaterialPageRoute(builder: (context) => GuestHomeInitPage()),)),
            ],
          )
        ],
      ),
    );
  }

}


