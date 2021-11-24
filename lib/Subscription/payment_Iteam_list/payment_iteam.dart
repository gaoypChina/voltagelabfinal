// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voltagelab/Subscription/Payment_page/payment_page.dart';
import 'package:voltagelab/helper/global.dart';

class PaymentListPage extends StatefulWidget {
  final int package_price;
  final String subscription_pack_name;
  final int subs_pack_month;

  const PaymentListPage(
      {Key? key,
      required this.package_price,
      required this.subscription_pack_name,
      required this.subs_pack_month})
      : super(key: key);

  @override
  _PaymentListPageState createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        title: Text(
          'পেমেন্ট অপশন',
          style: Global.bnPostListAppbarText,
        ),
      ),
      body: Column(
        children: [
          paymentiteamlist(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      payment_name: 'bkash',
                      payment_type: 0,
                      package_price: widget.package_price,
                      subscription_pack_name: widget.subscription_pack_name,
                      subs_pack_month: widget.subs_pack_month,
                    ),
                  ),
                );
              },
              imagechild: Image.asset(
                'images/bikash.png',
                height: 50,
              ),
              name: 'বিকাশ'),
          paymentiteamlist(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      payment_type: 1,
                      payment_name: 'nagad',
                      package_price: widget.package_price,
                      subscription_pack_name: widget.subscription_pack_name,
                      subs_pack_month: widget.subs_pack_month,
                    ),
                  ),
                );
              },
              imagechild:
                  // Image.asset(
                  //   'images/nagad.png',
                  //   height: 50,
                  // ),
                  SvgPicture.asset(
                'images/Nagad-Logo.svg',
                height: 40,
                width: 30,
                allowDrawingOutsideViewBox: true,
              ),
              name: 'নগদ'),
          paymentiteamlist(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      payment_type: 2,
                      payment_name: 'rocket',
                      package_price: widget.package_price,
                      subscription_pack_name: widget.subscription_pack_name,
                      subs_pack_month: widget.subs_pack_month,
                    ),
                  ),
                );
              },
              imagechild: Image.asset(
                'images/rocket.jpg',
                height: 45,
                width: 30,
              ),
              name: 'রকেট'),
        ],
      ),
    );
  }

  Widget paymentiteamlist(
      {GestureTapCallback? onTap, Widget? imagechild, String? name}) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.08,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          10,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                    child: imagechild),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  child: Text(
                    name!,
                    style: GoogleFonts.hindSiliguri(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
