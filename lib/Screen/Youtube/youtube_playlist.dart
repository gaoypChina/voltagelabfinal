import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/youtube_api_provider.dart';
import 'package:voltagelab/Screen/Youtube/playlist_iteam.dart';
import 'package:voltagelab/helper/global.dart';

class YoutubePlaylistPage extends StatefulWidget {
  const YoutubePlaylistPage({Key? key}) : super(key: key);

  @override
  _YoutubePlaylistPageState createState() => _YoutubePlaylistPageState();
}

class _YoutubePlaylistPageState extends State<YoutubePlaylistPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<YoutubeApiprovider>(context, listen: false)
        .getyoutubeallplaylist();
  }

  @override
  Widget build(BuildContext context) {
    final youtube = Provider.of<YoutubeApiprovider>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Global.appBarColor,
          title: Text(
            "ভিডিও",
            style: Global.gridTitleName,
          ),
        ),
        body: youtube.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: youtube.youtubePlaylist!.items.length,
                itemBuilder: (context, index) {
                  var playlistdata = youtube.youtubePlaylist!.items[index];
                  return Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 5),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaylistIteamPage(
                                        playlistname:
                                            playlistdata.snippet.title,
                                        playlistid: playlistdata.id,
                                        maxresult: playlistdata
                                            .contentDetails.itemCount,
                                      )));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    playlistdata.snippet.title,
                                    style: Global.titleOfList,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                      "${playlistdata.contentDetails.itemCount} টি ভিডিও",
                                      style: GoogleFonts.hindSiliguri(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal))
                                ],
                              ),
                              const Spacer(),
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
              ));
  }
}
