// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/pages/post_details_page.dart';

class PostPage extends StatefulWidget {
  final int categoryid;
  final String categoryname;
  final String sitename;
  const PostPage({
    Key? key,
    required this.categoryid,
    required this.categoryname,
    required this.sitename,
  }) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  ScrollController? scrollController;
  bool loading = false;
  int? previewpostlength;

  int perpagepost = 10;

  Future loadmorepost() async {
    perpagepost = perpagepost + 10;
    Provider.of<Postprovider>(context, listen: false)
        .getpost(widget.categoryid, perpagepost, widget.sitename);
    previewpostlength =
        Provider.of<Postprovider>(context, listen: false).postdata.length;
  }

  @override
  void initState() {
    Provider.of<Postprovider>(context, listen: false)
        .getpost(widget.categoryid, perpagepost, widget.sitename);
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Postprovider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.categoryname,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: post.isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : LazyLoadScrollView(
              onEndOfPage: loadmorepost,
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: post.postdata.length,
                  itemBuilder: (context, index) {
                    if (index == post.postdata.length - 1) {
                      if (post.postdata.length == previewpostlength) {
                        return Container();
                      } else if (post.postdata.length != previewpostlength) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                        // return Column(
                        //   children: [
                        //     SizedBox(
                        //       height: 30,
                        //       width: 50,
                        //       child: LoadingIndicator(
                        //         indicatorType: Indicator.lineScalePulseOutRapid,
                        //         colors: const [
                        //           Colors.red,
                        //           Colors.deepOrange,
                        //           Colors.yellowAccent,
                        //           Colors.green,
                        //           Colors.indigo
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // );
                      }
                    }
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(
                          bottom: 5, left: 10, right: 10, top: 10),
                      child: InkWell(
                        onTap: () {
                          print(post.postdata[index].id);
                          Provider.of<Postprovider>(context, listen: false)
                              .getpostdetails(
                                  post.postdata[index].id!, widget.sitename);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetailsPage(
                                sitename: widget.sitename,
                                postdata: post.postdata[index],
                                categoryid: widget.categoryid,
                                categoryname: widget.categoryname,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 120.0,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      margin: const EdgeInsets.all(5),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                        ),
                                        child: CachedNetworkImage(
                                          fadeInCurve: Curves.easeInBack,
                                          imageUrl: post.postdata[index]
                                              .yoastHeadJson!.ogImage[0].url!,
                                          filterQuality: FilterQuality.low,
                                          memCacheHeight: 200,
                                          maxHeightDiskCache: 200,
                                          fit: BoxFit.cover,
                                          // frameBuilder:
                                          //     (context, child, frame, wasSynchronouslyLoaded) {
                                          //   if (wasSynchronouslyLoaded) return child;
                                          //   return AnimatedOpacity(
                                          //     opacity: frame == null ? 0 : 1,
                                          //     duration: Duration(milliseconds: 400),
                                          //     curve: Curves.easeOut,
                                          //     child: child,
                                          //   );
                                          // },
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              post.postdata[index].title!
                                                  .rendered,
                                              softWrap: true,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              children: const [
                                                // Icon(Icons.favorite_border),
                                                // Spacer(),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}




//  if (index == post.postdata.length - 1) {
//                       if (post.postdata.length == previewpostlength) {
//                         return Container();
//                       } else if (post.postdata.length != previewpostlength) {
