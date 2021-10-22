// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';

class PaymentPage extends StatefulWidget {
  final String payment_name;
  final int package_price;
  final String subscription_pack_name;
  final int subs_pack_month;
  final int payment_type;
  const PaymentPage(
      {Key? key,
      required this.payment_name,
      required this.package_price,
      required this.subscription_pack_name,
      required this.payment_type,
      required this.subs_pack_month})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formkey = GlobalKey<FormState>();
  String? phone_number = "", transaction_Id = "";

  validationchack(BuildContext context) {
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
      subscription_date(context);
    }
  }

  subscription_date(BuildContext context) {
    final payment = Provider.of<PaymentProvider>(context, listen: false);

    final startdate = DateTime(
        payment.orginalDatetime!.datetime!.year,
        payment.orginalDatetime!.datetime!.month,
        payment.orginalDatetime!.datetime!.day,
        payment.orginalDatetime!.datetime!.hour,
        payment.orginalDatetime!.datetime!.minute,
        payment.orginalDatetime!.datetime!.millisecond,
        payment.orginalDatetime!.datetime!.microsecond);

    final enddate = DateTime(
        payment.orginalDatetime!.datetime!.year,
        widget.subs_pack_month == 1
            ? payment.orginalDatetime!.datetime!.month + 1
            : widget.subs_pack_month == 3
                ? payment.orginalDatetime!.datetime!.month + 3
                : widget.subs_pack_month == 6
                    ? payment.orginalDatetime!.datetime!.month + 6
                    : payment.orginalDatetime!.datetime!.month + 1,
        payment.orginalDatetime!.datetime!.day,
        payment.orginalDatetime!.datetime!.hour,
        payment.orginalDatetime!.datetime!.minute,
        payment.orginalDatetime!.datetime!.millisecond,
        payment.orginalDatetime!.datetime!.microsecond);
    final enddatecount = DateTime(
        payment.orginalDatetime!.datetime!.year,
        widget.subs_pack_month == 1
            ? payment.orginalDatetime!.datetime!.month + 1
            : widget.subs_pack_month == 3
                ? payment.orginalDatetime!.datetime!.month + 3
                : widget.subs_pack_month == 6
                    ? payment.orginalDatetime!.datetime!.month + 6
                    : payment.orginalDatetime!.datetime!.month + 1,
        payment.orginalDatetime!.datetime!.day);
    final startdatecount = DateTime(
        payment.orginalDatetime!.datetime!.year,
        payment.orginalDatetime!.datetime!.month,
        payment.orginalDatetime!.datetime!.day);
    final difference = enddatecount.difference(startdatecount).inDays;
    payment.payment_user_inputdata(
        phone_num: phone_number!,
        transactionid: transaction_Id,
        start_date: startdate.toString(),
        end_date: enddate.toString(),
        status: '0',
        subscription_pack: widget.subscription_pack_name,
        remaining: difference,
        payment_type: widget.payment_type,
        context: context);

    numbertrangitionidsend(phone_number!, transaction_Id, widget.payment_name,
        widget.subscription_pack_name, widget.subs_pack_month);
  }

  @override
  void initState() {
    Provider.of<PaymentProvider>(context, listen: false).get_today_datetime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  'Your order',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      'Product',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text('Subtotal',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text('Basic to Advance'),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('৳${widget.package_price}')),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text('Subtotal'),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('৳${widget.package_price}')),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('${widget.payment_name} Charge'),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text('৳0')),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '৳${widget.package_price}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              const Divider(),
              const SizedBox(height: 20),
              Flexible(child: bikashfrom()),
            ],
          ),
        ),
      ),
    );
  }

  Widget bikashfrom() {
    final payment = Provider.of<PaymentProvider>(context);
    return Card(
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                    'Please complete your bKash payment at first, then fill up the form below. Also note that 1.85% bKash "SEND MONEY" cost will be added with net price. Total amount you need to send us at ৳ 7130'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child:
                  Text('${widget.payment_name} Personal Number : 01751331330'),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('${widget.payment_name} number'),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        onSaved: (newValue) {
                          setState(() {
                            phone_number = newValue;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "${widget.payment_name} number";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            phone_number = value;
                          });
                        },
                        initialValue: "01",
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '${widget.payment_name} number',
                          border: const OutlineInputBorder(),
                          alignLabelWithHint: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 0, 10),
                          enabled: true,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text('${widget.payment_name} Transaction ID'),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        onSaved: (newValue) {
                          setState(() {
                            transaction_Id = newValue;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your ${widget.payment_name} Transaction ID";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            transaction_Id = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '${widget.payment_name} Transaction ID',
                          border: const OutlineInputBorder(),
                          alignLabelWithHint: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 0, 10),
                          enabled: true,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: payment.isloading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        validationchack(context);
                      },
                      child: const Text('Submit')),
            )
          ],
        ),
      ),
    );
  }

  Future numbertrangitionidsend(String number, transitionid, payment_name,
      subscriptionname, subs_pack_month) async {
    String host = 'voltagelab.com';

    String name = 'Voltage Lab';
    bool ignoreBadCertificate = false;
    bool ssl = false;
    bool allowInsecure = false;
    String username = 'otp@voltagelab.com';
    String password = 'mindofEYE@1';

    final smtpServer = SmtpServer(
      host,
      port: 587,
      name: name,
      allowInsecure: allowInsecure,
      username: username,
      password: password,
      ssl: ssl,
      ignoreBadCertificate: ignoreBadCertificate,
    );
    final message = Message()
      ..from = Address(username, name)
      ..recipients.add("rony.pvt@gmail.com")
      ..subject = 'Payment resive'
      ..text =
          'Number: ${number} Transition id: ${transaction_Id} payment name: $payment_name Subscription Name: $subscriptionname, Subscription Month: $subs_pack_month';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
