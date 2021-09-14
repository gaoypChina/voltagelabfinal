import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:share/share.dart';

class BookmarkPostDetails extends StatefulWidget {
  final int categoryid;
  final int id;
  final String date;
  final String link;
  final String title;
  final String content;
  final String yoastHeadJson;
  const BookmarkPostDetails({
    Key? key,
    required this.categoryid,
    required this.id,
    required this.date,
    required this.link,
    required this.title,
    required this.content,
    required this.yoastHeadJson,
  }) : super(key: key);

  @override
  _BookmarkPostDetailsState createState() => _BookmarkPostDetailsState();
}

class _BookmarkPostDetailsState extends State<BookmarkPostDetails> {

  void postshare(BuildContext context, String link) async {
    final scaffoldkey = GlobalKey<ScaffoldState>();

    final String text = link;
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.share(text,
        subject: "Voltage Lab",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Postprovider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.black),
            ),
            pinned: true,
            actions: [
              IconButton(
                  onPressed: () {
                    postshare(context, widget.link);
                  },
                  icon: Icon(Icons.share)),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: widget.yoastHeadJson,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Container(
                child: Html(
                  data: widget.content,
                  onLinkTap: (url, _, __, ___) async {
                    if (await canLaunch(url!)) {
                      await launch(
                        url,
                      );
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
