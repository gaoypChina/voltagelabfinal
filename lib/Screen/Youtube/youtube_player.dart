import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/youtube_api_provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerPage extends StatefulWidget {
  final String videoid;
  const YoutubePlayerPage({Key? key, required this.videoid}) : super(key: key);

  @override
  _YoutubePlayerPageState createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  @override
  void initState() {
    Provider.of<YoutubeApiprovider>(context, listen: false)
        .runyoutubevideo(widget.videoid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final youtube = Provider.of<YoutubeApiprovider>(context);
    final player = YoutubePlayerIFrame(
      controller: youtube.controller,
    );
    return YoutubePlayerControllerProvider(
        controller: youtube.controller!, child: player);
  }
}
