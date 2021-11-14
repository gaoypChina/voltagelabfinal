import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/helper/global.dart';
import 'package:voltagelab/web_View/web_view.dart';

class LatestPostDetails extends StatefulWidget {
  final int latestpostid;
  final String latestposttitle;

  final String latestpostpic;
  const LatestPostDetails(
      {Key? key,
      required this.latestpostid,
      required this.latestposttitle,
      required this.latestpostpic})
      : super(key: key);

  @override
  _LatestPostDetailsState createState() => _LatestPostDetailsState();
}

class _LatestPostDetailsState extends State<LatestPostDetails> {
  void postshare(BuildContext context, String link) async {
    final String text = link;
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(text,
        subject: "Voltage Lab",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    Provider.of<Postprovider>(context, listen: false)
        .getlatestpostdetails(widget.latestpostid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Postprovider>(context);
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
              widget.latestposttitle,
              style: Global.titleCarosal,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    postshare(context, post.postDetails!.link);
                  },
                  icon: const Icon(Icons.share)),
            ],
          ),
          //       SliverPersistentHeader(
          // delegate: DetailsSliverdelegate(
          //     expendedheigth: expanded_heigth,
          //     photourl: widget.latestpostpic,
          //     round_container: round_container_heigth)),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: widget.latestpostpic,
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
                      widget.latestposttitle,
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
              physics: BouncingScrollPhysics(),
              child: post.latestPostdetails == null
                  ? const SizedBox(
                      height: 300,
                      child: Center(
                        child: Text("Loading........"),
                      ),
                    )
                  : Html(
                      data: post.latestPostdetails!.content.rendered,
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
