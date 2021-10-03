// ignore_for_file: iterable_contains_unrelated_type, avoid_print, unused_element
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:share/share.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/web_View/web_view.dart';


class SearchPostDetails extends StatefulWidget {
  final int postid;
  const SearchPostDetails({
    Key? key,
    required this.postid,
  }) : super(key: key);

  @override
  _SearchPostDetailsState createState() => _SearchPostDetailsState();
}

class _SearchPostDetailsState extends State<SearchPostDetails> {
  bool isloading = false;

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
    final post = Provider.of<Postprovider>(context);
    return Scaffold(
      body: post.searchpostloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black),
                  title: Text(
                    post.searchPostDetails!.title.rendered!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  pinned: true,
                  actions: [
                    IconButton(
                        onPressed: () {
                          postshare(context, post.searchPostDetails!.link);
                        },
                        icon: const Icon(Icons.share)),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        key: UniqueKey(),
                        imageUrl: post
                            .searchPostDetails!.yoastHeadJson.ogImage![0].url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            post.searchPostDetails!.title.rendered!,
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
                      data: post.searchPostDetails!.content.rendered,
                      onLinkTap: (url, _, __, ___) async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewPage(url: url!),
                            ));
                      },
                      onImageTap: (url, context, attributes, element) {
                        CachedNetworkImage(imageUrl: url!);
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
