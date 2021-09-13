import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/model/post_model.dart';
import 'package:share/share.dart';

class PostDetailsPage extends StatefulWidget {
  final Postdata postdata;
  const PostDetailsPage({Key? key, required this.postdata}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  Box? box;

  // htmlremove() {
  //   htmldata.clear();
  //   var documents = parse(widget.postdata.content!.rendered);
  //   documents
  //       .getElementsByTagName("p,h2,h3,ul,div,")
  //       .map((e) => e.outerHtml)
  //       .toList();
  // }

  void postshare(BuildContext context, String link) async {
    final String text = link;
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.share(text,
        subject: "Voltage Lab",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    box = Hive.box('bookmark');
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
              widget.postdata.title!.rendered!,
              style: TextStyle(color: Colors.black),
            ),
            pinned: true,
            actions: [
              IconButton(
                  onPressed: () {
                    postshare(context, widget.postdata.link!);
                  },
                  icon: Icon(Icons.share)),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  widget.postdata.yoastHeadJson!.ogImage![0].url!,
                  fit: BoxFit.cover,
                ),
              ),
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
                      widget.postdata.title!.rendered!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      post.savepost(
                        id: widget.postdata.id!,
                        date: widget.postdata.date!.toString(),
                        link: widget.postdata.link!,
                        title: widget.postdata.title!.rendered!,
                        content: widget.postdata.content!.rendered!,
                        yoastHeadJson:
                            widget.postdata.yoastHeadJson!.ogImage![0].url!,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(box!.values.any(
                              (element) => element['id'] == widget.postdata.id)
                          ? Icons.bookmark_sharp
                          : Icons.bookmark_border),
                    ),
                  )
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
                  data: widget.postdata.content!.rendered,
                  style: {"figure": Style(height: 300)},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
