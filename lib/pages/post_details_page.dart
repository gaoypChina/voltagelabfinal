import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:voltagelab/model/post_model.dart';

class PostDetailsPage extends StatefulWidget {
  final Postdata postdata;
  const PostDetailsPage({Key? key, required this.postdata}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.postdata.title!.rendered!),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.postdata.yoastHeadJson!.ogImage![0].url!,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              
              child: Html(
                data: widget.postdata.content!.rendered,
                shrinkWrap: true,
                
              ),
            ),
          )
        ],
      ),
    );
  }
}
