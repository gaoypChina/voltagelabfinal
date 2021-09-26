import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/Notification/OneSignal/Model/postdetails.dart';

class OneSignalPostdetails extends StatefulWidget {
  final int postid;
  const OneSignalPostdetails({Key? key, required this.postid})
      : super(key: key);

  @override
  _OneSignalPostdetailsState createState() => _OneSignalPostdetailsState();
}

class _OneSignalPostdetailsState extends State<OneSignalPostdetails> {
  Future<NotificationPostDetails?> getnotificationpostdetails() async {
    String url =
        "https://amrkotha.org/wp-json/wp/v2/posts/${widget.postid}?_fields[]=id&_fields[]=link&_fields[]=title&_fields[]=content";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      return notificationPostDetailsFromJson(jsondata);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<NotificationPostDetails?>(
        future: getnotificationpostdetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(snapshot.data!.title!.rendered!),
                ),
                SliverToBoxAdapter(
                  child: Html(data: snapshot.data!.content!.rendered),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
