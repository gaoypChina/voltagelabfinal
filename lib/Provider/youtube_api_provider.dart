// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/Youtube%20Model/playlist_iteam_model.dart';
import 'package:voltagelab/model/Youtube%20Model/youtube_playlist_model.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeApiprovider extends ChangeNotifier {
  YoutubePlayerController? controller;
  YoutubePlaylist? youtubePlaylist;
  YoutubePlaylistiteam? youtubePlaylistiteam;
  bool loading = false;

  Future getyoutubeallplaylist() async {
    loading = true;
    String url =
        "https://youtube.googleapis.com/youtube/v3/playlists?part=snippet%2CcontentDetails&channelId=UCc563YrEuBHKNAxQFJ8Gi7A&maxResults=25&key=AIzaSyCNc-j6dND2JR4TZLCCvFGa-upvOZCTXLM&fields=items(id,snippet(channelTitle,channelId,title),contentDetails)";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      youtubePlaylist = youtubePlaylistFromJson(response.body);
      loading = false;
      notifyListeners();
    }
  }

  Future playlistiteam(String playlistid, int maxResults) async {
    print("max_resultsss $maxResults");
    loading = true;
    String url =
        "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${playlistid}&key=AIzaSyCNc-j6dND2JR4TZLCCvFGa-upvOZCTXLM&part=snippet&maxResults=${maxResults}&fields=items(id,snippet(title,channelTitle,resourceId(videoId)))";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      youtubePlaylistiteam = youtubePlaylistiteamFromJson(response.body);
      loading = false;
      notifyListeners();
    }
  }

  runyoutubevideo(String videoid) {
    controller = YoutubePlayerController(
      initialVideoId: videoid,
      params: const YoutubePlayerParams(
        autoPlay: true,
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: false,
        useHybridComposition: false,
      ),
    );
   
  }
}
