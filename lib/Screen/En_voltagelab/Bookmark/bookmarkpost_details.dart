// ignore_for_file: unused_element

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:share/share.dart';
import 'package:voltagelab/web_View/web_view.dart';

class En_voltagelabBookmarkPostDetails extends StatefulWidget {
  final int categoryid;
  final int id;
  final String link;
  final String title;
  final String content;
  final String yoastHeadJson;
  const En_voltagelabBookmarkPostDetails({
    Key? key,
    required this.categoryid,
    required this.id,
    required this.link,
    required this.title,
    required this.content,
    required this.yoastHeadJson,
  }) : super(key: key);

  @override
  _En_voltagelabBookmarkPostDetailsState createState() => _En_voltagelabBookmarkPostDetailsState();
}

class _En_voltagelabBookmarkPostDetailsState extends State<En_voltagelabBookmarkPostDetails> {

  void postshare(BuildContext context, String link) async {

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
        double expanded_heigth = 300;
    double round_container_heigth = 50;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.black),
            ),
            pinned: true,
            actions: [
              IconButton(
                  onPressed: () {
                    postshare(context, widget.link);
                  },
                  icon: const Icon(Icons.share)),
            ],
          ),
                   SliverPersistentHeader(
            delegate: DetailsSliverdelegate(
                expendedheigth: expanded_heigth,
                photourl: widget.yoastHeadJson,
                round_container: round_container_heigth),
          ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     margin: const EdgeInsets.all(10),
          //     child: ClipRRect(
          //         borderRadius: BorderRadius.circular(5),
          //         child: CachedNetworkImage(
          //           imageUrl: widget.yoastHeadJson,
          //           fit: BoxFit.cover,
          //         )),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
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
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: const Divider(),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Html(
                data: widget.content,
                onLinkTap: (url, _, __, ___) async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewPage(url: url!),
                            ));
                      },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DetailsSliverdelegate extends SliverPersistentHeaderDelegate {
  final double expendedheigth;
  final String photourl;
  final double round_container;
  const DetailsSliverdelegate(
      {required this.photourl,
      required this.expendedheigth,
      required this.round_container});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Scaffold(
      body: Stack(
        children: [
          // Image.network(
          //   photourl,
          //   width: MediaQuery.of(context).size.width,
          //   height: expendedheigth,
          //   fit: BoxFit.cover,
          // ),
          CachedNetworkImage(
            key: UniqueKey(),
            imageUrl: photourl,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: expendedheigth,
          ),
          Positioned(
            top: expendedheigth - round_container + 25 - shrinkOffset,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: round_container - 10,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => expendedheigth;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
