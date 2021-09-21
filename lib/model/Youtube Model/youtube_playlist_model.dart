// To parse this JSON data, do
//
//     final youtubePlaylist = youtubePlaylistFromJson(jsonString);

import 'dart:convert';

YoutubePlaylist youtubePlaylistFromJson(String str) => YoutubePlaylist.fromJson(json.decode(str));

String youtubePlaylistToJson(YoutubePlaylist data) => json.encode(data.toJson());

class YoutubePlaylist {
    YoutubePlaylist({
        required this.items,
    });

    List<Item> items;

    factory YoutubePlaylist.fromJson(Map<String, dynamic> json) => YoutubePlaylist(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    Item({
        required this.id,
        required this.snippet,
        required this.contentDetails,
    });

    String id;
    Snippet snippet;
    ContentDetails contentDetails;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        snippet: Snippet.fromJson(json["snippet"]),
        contentDetails: ContentDetails.fromJson(json["contentDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "snippet": snippet.toJson(),
        "contentDetails": contentDetails.toJson(),
    };
}

class ContentDetails {
    ContentDetails({
        required this.itemCount,
    });

    int itemCount;

    factory ContentDetails.fromJson(Map<String, dynamic> json) => ContentDetails(
        itemCount: json["itemCount"],
    );

    Map<String, dynamic> toJson() => {
        "itemCount": itemCount,
    };
}

class Snippet {
    Snippet({
        required this.channelId,
        required this.title,
        required this.channelTitle,
    });

    String channelId;
    String title;
    String channelTitle;

    factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        channelId: json["channelId"],
        title: json["title"],
        channelTitle: json["channelTitle"],
    );

    Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "title": title,
        "channelTitle": channelTitle,
    };
}
