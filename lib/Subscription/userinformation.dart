// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/widget/textfield.dart';

class SubsUSerInformation extends StatefulWidget {
  const SubsUSerInformation({Key? key}) : super(key: key);

  @override
  _SubsUSerInformationState createState() => _SubsUSerInformationState();
}

class _SubsUSerInformationState extends State<SubsUSerInformation> {
  final _formkey = GlobalKey<FormState>();
  String? fullname, lastname, email, phonenumber, address;

  validationchack(BuildContext context) {
    final from = _formkey.currentState;
    if (from!.validate()) {
      from.save();
      subscription_date(fullname, lastname, email, phonenumber, address);
    }
  }

  subscription_date(String? fullname, lastname, email, phonenumber, address) {
    final payment = Provider.of<PaymentProvider>(context, listen: false);
    String? startday =
        "${payment.orginalDatetime!.datetime!.month}-${payment.orginalDatetime!.datetime!.day}-${payment.orginalDatetime!.datetime!.year}";
    if (payment.orginalDatetime!.datetime!.month == 12) {
      String endtime =
          "${1}-${payment.orginalDatetime!.datetime!.day}-${payment.orginalDatetime!.datetime!.year + 1}";
      // payment.payment_user_inputdata(
      //     fullname!, email, phonenumber, address, startday, endtime, 'panding');
      print(endtime);
    } else {
      String endtime =
          "${payment.orginalDatetime!.datetime!.month + 1}-${payment.orginalDatetime!.datetime!.day}-${payment.orginalDatetime!.datetime!.year}";
      // payment.payment_user_inputdata(
      //     fullname!, email, phonenumber, address, startday, endtime, 'panding');
    }
  }

  @override
  void initState() {
    Provider.of<PaymentProvider>(context, listen: false).get_today_datetime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userdata");
    final payment = Provider.of<PaymentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormFieldpage(
              keybordtype: TextInputType.name,
              initialValue: box.get('name'),
              name: 'Fullname',
              onsave: (newValue) {
                setState(() {
                  fullname = newValue;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter full name';
                }
              },
            ),
            TextFormFieldpage(
              keybordtype: TextInputType.emailAddress,
              initialValue: box.get('email'),
              name: 'Email',
              onsave: (newValue) {
                setState(() {
                  email = newValue;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your email';
                }
              },
            ),
            TextFormFieldpage(
              keybordtype: TextInputType.phone,
              initialValue: '',
              name: 'Phone Number',
              onsave: (newValue) {
                setState(() {
                  phonenumber = newValue;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your phone number';
                }
              },
            ),
            TextFormFieldpage(
              keybordtype: TextInputType.streetAddress,
              initialValue: '',
              name: 'Address',
              onsave: (newValue) {
                setState(() {
                  address = newValue;
                });
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your address';
                }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  validationchack(context);
                },
                child: const Text('Next'))
          ],
        ),
      ),
    );
  }
}
