
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voltagelab/helper/global.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  // final controllerTo = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();

  bool _validateTo = false;
  bool _validateSubject = false;
  bool _validateMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: (Text("Contact Us", style: Global.entitleName)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
              alignment: Alignment.center,
              child: Text(
                "Contact in Mail",
                style: Global.encategoryTitleText,
              ),
            ),
            // buildTextField(
            //     title: 'To',
            //     controller: controllerTo,
            //     validateTxt: _validateTo,
            //     maxLine: 1),

            const SizedBox(
              height: 10.0,
            ),
            buildTextField(
                title: 'Subject',
                controller: controllerSubject,
                validateTxt: _validateSubject,
                maxLine: 1),
            SizedBox(
              height: 15.0,
            ),
            buildTextField(
                title: 'Body',
                controller: controllerMessage,
                validateTxt: _validateMessage,
                maxLine: 3),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (controllerSubject.text.isEmpty) {
                    _validateSubject = true;
                  } else {
                    _validateSubject = false;
                  }
                  if (controllerMessage.text.isEmpty) {
                    _validateMessage = true;
                  } else {
                    _validateMessage = false;
                  }
                  // send mail if both field is not empty
                  if (controllerSubject.text.isNotEmpty &&
                      controllerMessage.text.isNotEmpty) {
                    _openMailLauncher(
                        toEmil: "voltagelabbd@gmail.com",
                        toSubject: controllerSubject.text,
                        message: controllerMessage.text);
                  }
                });
              },
              child: Text(
                "Send",
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),

            Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Note: When we get your mail, we will contact you through the mail.",
                        // style: TextStyle(
                        //     color: Colors.red, fontWeight: FontWeight.bold),
                        style: GoogleFonts.lato(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                    child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "Or Whatsapp Live Chat!!!",
                          style: Global.encategoryTitleText,
                        ))),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 100, right: 100),
              // color: Colors.green,
              width: 200,
              height: 50,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: () {
                    openwhatsapp();
                  },
                  // child: Container(
                  // color: Colors.grey,
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outlined,
                        color: Color.fromRGBO(7, 94, 84, 5),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Live Chat",
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                  // ),
                ),
              ),
            )
            // Container(
            //   child: Container(
            //     margin: EdgeInsets.only(top: 10),
            //     width: double.infinity,
            //     alignment: Alignment.center,
            //     child: Text(
            //       "Or Whatsapp Live Chat!!!",
            //       style: Global.encategoryTitleText,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      {required String title,
      required TextEditingController controller,
      required bool validateTxt,
      required int maxLine}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 16,
            )),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: controller,
          maxLines: maxLine,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              errorText: validateTxt ? 'Value Can\'t be Empty' : null),
        )
      ],
    );
  }
}

Future _openMailLauncher(
    {required String toEmil,
    required String toSubject,
    required String message}) async {
  final url =
      'mailto: $toEmil?subject=${Uri.encodeFull(toSubject)}&body=${Uri.encodeFull(message)}';
  launch(url);
  // if (await canLaunch(url)) {
  //   print("2 buttonclick");

  //   await launch(url);
  // }
}

openwhatsapp() async{
  var whatsapp ="+8801713509349";
  var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=[From: VoltageLab App]\n\n";

    // android , web
    // if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    // }else{
    //
    // }

}

