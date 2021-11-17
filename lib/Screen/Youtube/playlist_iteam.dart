import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/youtube_api_provider.dart';
import 'package:voltagelab/Screen/Youtube/youtube_player.dart';
import 'package:voltagelab/helper/global.dart';

class PlaylistIteamPage extends StatefulWidget {
  final String playlistid;
  final String playlistname;
  final int maxresult;
  const PlaylistIteamPage(
      {Key? key,
      required this.playlistid,
      required this.maxresult,
      required this.playlistname})
      : super(key: key);

  @override
  _PlaylistIteamPageState createState() => _PlaylistIteamPageState();
}

class _PlaylistIteamPageState extends State<PlaylistIteamPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<YoutubeApiprovider>(context, listen: false)
        .playlistiteam(widget.playlistid, widget.maxresult);

    // _controller!.onEnterFullscreen = () {
    //   SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.landscapeLeft,
    //     DeviceOrientation.landscapeRight,
    //   ]);
    //   log('Entered Fullscreen');
    // };
    // _controller!.onExitFullscreen = () {
    //   log('Exited Fullscreen');
    // };
  }

  @override
  Widget build(BuildContext context) {
    final youtube = Provider.of<YoutubeApiprovider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 221,
                  color: Colors.black,
                  child: youtube.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : YoutubePlayerPage(
                          videoid: youtube.youtubePlaylistiteam!.items[0]
                              .snippet.resourceId.videoId),
                ),
              ],
            ),
            Container(
              height: 50,
              color: Global.defaultColor,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  Text(
                    widget.playlistname,
                    style: Global.bntitleOfAppbar,
                  ),
                ],
              ),
            ),
            youtube.loading
                ? const SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Flexible(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: youtube.youtubePlaylistiteam!.items.length,
                        itemBuilder: (context, index) {
                          var iteamdata =
                              youtube.youtubePlaylistiteam!.items[index];
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 5),
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  youtube.controller!.load(
                                      iteamdata.snippet.resourceId.videoId);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(iteamdata.snippet.title,
                                            style: Global.titleOfList),
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.grey[400],
                                        size: 17,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}




// Flexible(
//                         child: SingleChildScrollView(
//                           child: ListView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount:
//                                 youtube.youtubePlaylistiteam!.items.length,
//                             itemBuilder: (context, index) {
//                               var iteamdata =
//                                   youtube.youtubePlaylistiteam!.items[index];
//                               return Container(
//                                 margin: const EdgeInsets.only(
//                                     left: 10, right: 10, top: 10, bottom: 5),
//                                 decoration:
//                                     const BoxDecoration(color: Colors.white),
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         youtubePlayerController!.load(iteamdata
//                                             .snippet.resourceId.videoId);
//                                       });
//                                     },
//                                     child: Container(
//                                       padding: const EdgeInsets.all(15),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Flexible(
//                                               child: Text(
//                                                   iteamdata.snippet.title)),
//                                           Icon(
//                                             Icons.check_circle,
//                                             color: Colors.grey[400],
//                                             size: 17,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       )
