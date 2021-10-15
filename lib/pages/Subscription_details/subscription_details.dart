import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';

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
        title: Text("Subscription Details"),
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
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
