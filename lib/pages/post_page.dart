import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/model/subcategory.dart';
import 'package:voltagelab/pages/post_details_page.dart';

class PostPage extends StatefulWidget {
  final int categoryid;
  final String categoryname;
  const PostPage({
    Key? key,
    required this.categoryid,
    required this.categoryname,
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
        .getpost(widget.categoryid, perpagepost);
    previewpostlength =
        Provider.of<Postprovider>(context, listen: false).postdata.length;
  }

  @override
  void initState() {
    Provider.of<Postprovider>(context, listen: false)
        .getpost(widget.categoryid, perpagepost);
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
    return Container(
      child: post.isloading == true
          ? Container(
              child: Center(
                child: CupertinoActivityIndicator(
                  radius: 10,
                ),
              ),
            )
          : Scrollbar(
              child: LazyLoadScrollView(
                onEndOfPage: loadmorepost,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: post.postdata.length,
                    itemBuilder: (context, index) {
                      if (index == post.postdata.length - 1) {
                        if (post.postdata.length == previewpostlength) {
                          return Container();
                        } else if (post.postdata.length != previewpostlength) {
                          return Column(
                            children: [
                              Container(
                                height: 30,
                                width: 50,
                                child: LoadingIndicator(
                                  indicatorType:
                                      Indicator.lineScalePulseOutRapid,
                                  colors: const [
                                    Colors.red,
                                    Colors.deepOrange,
                                    Colors.yellowAccent,
                                    Colors.green,
                                    Colors.indigo
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      }
                      return postdata(post, index);
                    },
                  ),
                ),
              ),
            ),
    );
  }

  postdata(Postprovider post, int index) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailsPage(
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
              child: Container(
                height: 120.0,
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      margin: EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        child: Image.network(
                          post.postdata[index].yoastHeadJson!.ogImage![0].url!,
                          cacheHeight: 220,
                          fit: BoxFit.cover,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) return child;
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              post.postdata[index].title!.rendered!,
                              softWrap: true,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                Icon(Icons.favorite_border),
                                Spacer(),
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
  }
}

// Container(
//       margin: EdgeInsets.all(5),
//       child: Card(
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       PostDetailsPage(postdata: post.postdata[index]),
//                 ),
//               );
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       height: 200,
//                       width: double.infinity,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(5),
//                           topRight: Radius.circular(5),
//                         ),
//                         child: Image.network(
//                           post.postdata[index].yoastHeadJson!.ogImage![0].url!,
//                           cacheHeight: 300,
//                           fit: BoxFit.cover,
//                           frameBuilder:
//                               (context, child, frame, wasSynchronouslyLoaded) {
//                             if (wasSynchronouslyLoaded) return child;
//                             return AnimatedOpacity(
//                               opacity: frame == null ? 0 : 1,
//                               duration: Duration(milliseconds: 400),
//                               curve: Curves.easeOut,
//                               child: child,
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Container(
//                         margin: EdgeInsets.all(5),
//                         padding: EdgeInsets.only(
//                             left: 10, right: 10, top: 5, bottom: 5),
//                         child: Text(widget.subcategory.name!),
//                         decoration: BoxDecoration(
//                             color: Colors.orange,
//                             borderRadius: BorderRadius.circular(5)),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(post.postdata[index].title!.rendered!),
//                       SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.timer,
//                             size: 18,
//                           ),
//                           SizedBox(width: 2),
//                           Text("${post.postdata[index].date!.hour} Hours Ago"),
//                           Spacer(),
//                           IconButton(
//                               constraints: BoxConstraints(maxHeight: 36),
//                               onPressed: () {},
//                               icon: Icon(Icons.favorite),
//                               padding: EdgeInsets.all(0.0))
//                         ],
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
