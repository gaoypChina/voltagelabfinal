import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/helper/global.dart';

class SubscriptionDetailsPage extends StatefulWidget {
  const SubscriptionDetailsPage({Key? key}) : super(key: key);

  @override
  _SubscriptionDetailsPageState createState() =>
      _SubscriptionDetailsPageState();
}

class _SubscriptionDetailsPageState extends State<SubscriptionDetailsPage> {
  @override
  void initState() {
    Provider.of<PaymentProvider>(context, listen: false)
        .subscription_details_page();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final payment = Provider.of<PaymentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("সাবস্ক্রিবশন তথ্য", style: Global.bnPostListAppbarText,),
      ),
      body: payment.isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Html(
                      data: payment.subscriptionDetailspage!.content!.rendered,
                      // onLinkTap: (url, _, __, ___) async {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => WebViewPage(url: url!),
                      //       ));
                      // },
                      // onImageTap: (url, context, attributes, element) {
                      //   CachedNetworkImage(imageUrl: url!);
                      // },
                      style: {
                        // "p": Style(fontSize: FontSize(textsize.textsize), fontFamily: 'SolaimanLipi', letterSpacing: 1.0),

                        "p": Style(fontSize: FontSize(18), fontFamily: 'SolaimanLipi', letterSpacing: 1.5, lineHeight:LineHeight(1.8) ),
                        "li": Style(fontSize:  FontSize(18), fontFamily: 'SolaimanLipi', letterSpacing: 1.5, lineHeight:LineHeight(1.8)),
                        "strong":  Style(fontSize: FontSize(18), fontFamily: 'SolaimanLipi'),
                        "h1":  Style(fontSize: FontSize(24), fontFamily: 'SolaimanLipi'),
                        "h2":  Style(fontSize: FontSize(22), fontFamily: 'SolaimanLipi'),
                        "h3":  Style(fontSize: FontSize(18), fontFamily: 'SolaimanLipi'),
                        "h4":  Style(fontSize: FontSize(16), fontFamily: 'SolaimanLipi'),
                        "h5":  Style(fontSize: FontSize(12), fontFamily: 'SolaimanLipi'),
                        "h6":  Style(fontSize: FontSize(10), fontFamily: 'SolaimanLipi')
                      },
                    ),

                  ),
                )
              ],
            ),
    );
  }
}
