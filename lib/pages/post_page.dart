import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/model/category_model.dart';
import 'package:voltagelab/pages/post_details_page.dart';

class PostPage extends StatefulWidget {
  final Categories categories;
  const PostPage({Key? key, required this.categories}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  ScrollController? scrollController;
  bool loading = false;
  int? previewpostlength;

  List postlist = [];
  int perpagepost = 10;

  Future loadmorepost() async {
    perpagepost = perpagepost + 10;
    Provider.of<Postprovider>(context, listen: false)
        .getpost(widget.categories.id!, perpagepost);
    previewpostlength =
        Provider.of<Postprovider>(context, listen: false).postdata.length;
  }

  @override
  void initState() {
    Provider.of<Postprovider>(context, listen: false)
        .getpost(widget.categories.id!, perpagepost);
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
                child: CircularProgressIndicator(),
              ),
            )
          : Scrollbar(
              child: LazyLoadScrollView(
                onEndOfPage: loadmorepost,
                child: ListView.builder(
                  shrinkWrap: true,
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
                                indicatorType: Indicator.lineScalePulseOutRapid,
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
    );
  }

  postdata(Postprovider post, int index) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PostDetailsPage(postdata: post.postdata[index]),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        child: Image.network(
                          post.postdata[index].yoastHeadJson!.ogImage![0].url!,
                          cacheHeight: 300,
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
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Text(widget.categories.name!),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.postdata[index].title!.rendered!),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("${post.postdata[index].date!.hour} Hours Ago"),
                          Spacer(),
                          IconButton(
                              constraints: BoxConstraints(maxHeight: 36),
                              onPressed: () {},
                              icon: Icon(Icons.favorite),
                              padding: EdgeInsets.all(0.0))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
