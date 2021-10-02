import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';

class PaymentPage extends StatefulWidget {
  final String payment_name;
  final int package_price;
  final String subscription_pack_name;
  const PaymentPage(
      {Key? key,
      required this.payment_name,
      required this.package_price,
      required this.subscription_pack_name})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formkey = GlobalKey<FormState>();
  String? bkash_nuumber = "", bkash_transaction_Id = "";
  String? nagat_number = "", nagat_transaction_Id = "";
  String? rocket_number = "", rocket_transaction_Id = "";

  validationchack(BuildContext context) {
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
      subscription_date(context);
    }
  }

  subscription_date(BuildContext context) {
    final payment = Provider.of<PaymentProvider>(context, listen: false);
    // String? startdate =
    //     "${payment.orginalDatetime!.datetime!.month}-${payment.orginalDatetime!.datetime!.day}-${payment.orginalDatetime!.datetime!.year}";
    final startdate = DateTime(
      payment.orginalDatetime!.datetime!.year,
      payment.orginalDatetime!.datetime!.month,
      payment.orginalDatetime!.datetime!.day,
      payment.orginalDatetime!.datetime!.hour,
      payment.orginalDatetime!.datetime!.minute,
      payment.orginalDatetime!.datetime!.millisecond,
      payment.orginalDatetime!.datetime!.microsecond
    );
    if (payment.orginalDatetime!.datetime!.month == 12) {
      // String enddate =
      //     "${1}-${payment.orginalDatetime!.datetime!.day}-${payment.orginalDatetime!.datetime!.year + 1}";
          final enddate = DateTime(
      payment.orginalDatetime!.datetime!.year + 1,
      payment.orginalDatetime!.datetime!.month - 11,
      payment.orginalDatetime!.datetime!.day,
      payment.orginalDatetime!.datetime!.hour,
      payment.orginalDatetime!.datetime!.minute,
      payment.orginalDatetime!.datetime!.millisecond,
      payment.orginalDatetime!.datetime!.microsecond
    );
      final enddatecount = DateTime(payment.orginalDatetime!.datetime!.year + 1,
          1, payment.orginalDatetime!.datetime!.day);
      final startdatecount = DateTime(
          payment.orginalDatetime!.datetime!.year,
          payment.orginalDatetime!.datetime!.month,
          payment.orginalDatetime!.datetime!.day);
      final difference = enddatecount.difference(startdatecount).inDays;
      payment.payment_user_inputdata(
          bikash_phone_number: bkash_nuumber!,
          bkash_transaction_id: bkash_transaction_Id,
          nagad_phone_number: nagat_number,
          nagad_transaction_id: nagat_transaction_Id,
          rocket_phone_number: rocket_number,
          rocket_transaction_id: rocket_transaction_Id,
          start_date: startdate,
          end_date: enddate,
          status: 'panding',
          subscription_pack: widget.subscription_pack_name,
          remaining: difference,
          context: context);
    } else {
      // String enddate =
      //     "${payment.orginalDatetime!.datetime!.month + 1}-${payment.orginalDatetime!.datetime!.day}-${payment.orginalDatetime!.datetime!.year}";
      final enddate = DateTime(
      payment.orginalDatetime!.datetime!.year,
      payment.orginalDatetime!.datetime!.month + 1,
      payment.orginalDatetime!.datetime!.day,
      payment.orginalDatetime!.datetime!.hour,
      payment.orginalDatetime!.datetime!.minute,
      payment.orginalDatetime!.datetime!.millisecond,
      payment.orginalDatetime!.datetime!.microsecond
    );
      final enddatecount = DateTime(
          payment.orginalDatetime!.datetime!.year,
          payment.orginalDatetime!.datetime!.month + 1,
          payment.orginalDatetime!.datetime!.day);
      final startdatecount = DateTime(
          payment.orginalDatetime!.datetime!.year,
          payment.orginalDatetime!.datetime!.month,
          payment.orginalDatetime!.datetime!.day);
      final difference = enddatecount.difference(startdatecount).inDays;
      payment.payment_user_inputdata(
          bikash_phone_number: bkash_nuumber!,
          bkash_transaction_id: bkash_transaction_Id,
          nagad_phone_number: nagat_number,
          nagad_transaction_id: nagat_transaction_Id,
          rocket_phone_number: rocket_number,
          rocket_transaction_id: rocket_transaction_Id,
          start_date: startdate.toString(),
          end_date: enddate.toString(),
          status: 'panding',
          subscription_pack: widget.subscription_pack_name,
          remaining: difference,
          context: context);
    }
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
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
      color: Colors.grey[300],
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            if (widget.payment_name == 'Bkash') {
                              bkash_nuumber = newValue!;
                            } else if (widget.payment_name == 'Nagad') {
                              nagat_number = newValue!;
                            } else if (widget.payment_name == 'Rocket') {
                              rocket_number = newValue!;
                            }
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "${widget.payment_name} number";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            if (widget.payment_name == 'Bkash') {
                              bkash_nuumber = value;
                              print(widget.payment_name);
                            } else if (widget.payment_name == 'Nagad') {
                              nagat_number = value;
                              print(widget.payment_name);
                            } else if (widget.payment_name == 'Rocket') {
                              rocket_number = value;
                              print(widget.payment_name);
                            }
                          });
                        },
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
                            if (widget.payment_name == 'Bkash') {
                              bkash_transaction_Id = newValue!;
                            } else if (widget.payment_name == 'Nagad') {
                              nagat_transaction_Id = newValue!;
                            } else if (widget.payment_name == 'Rocket') {
                              rocket_transaction_Id = newValue!;
                            }
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your ${widget.payment_name} Transaction ID";
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            if (widget.payment_name == 'Bkash') {
                              bkash_transaction_Id = value;
                            } else if (widget.payment_name == 'Nagad') {
                              nagat_transaction_Id = value;
                              print(widget.payment_name);
                            } else if (widget.payment_name == 'Rocket') {
                              rocket_transaction_Id = value;
                            }
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
}