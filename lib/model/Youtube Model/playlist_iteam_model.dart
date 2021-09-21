// To parse this JSON data, do
//
//     final youtubePlaylistiteam = youtubePlaylistiteamFromJson(jsonString);

import 'dart:convert';

YoutubePlaylistiteam youtubePlaylistiteamFromJson(String str) => YoutubePlaylistiteam.fromJson(json.decode(str));

String youtubePlaylistiteamToJson(YoutubePlaylistiteam data) => json.encode(data.toJson());

class YoutubePlaylistiteam {
    YoutubePlaylistiteam({
        required this.items,
    });

    List<Item> items;

    factory YoutubePlaylistiteam.fromJson(Map<String, dynamic> json) => YoutubePlaylistiteam(
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
    });

    String id;
    Snippet snippet;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        snippet: Snippet.fromJson(json["snippet"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "snippet": snippet.toJson(),
    };
}

class Snippet {
    Snippet({
        required this.title,
        required this.channelTitle,
        required this.resourceId,
    });

    String title;
    String channelTitle;
    ResourceId resourceId;

    factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        title: json["title"],
        channelTitle: json["channelTitle"],
        resourceId: ResourceId.fromJson(json["resourceId"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "channelTitle": channelTitle,
        "resourceId": resourceId.toJson(),
    };
}

class ResourceId {
    ResourceId({
        required this.videoId,
    });

    String videoId;

    factory ResourceId.fromJson(Map<String, dynamic> json) => ResourceId(
        videoId: json["videoId"],
    );

    Map<String, dynamic> toJson() => {
        "videoId": videoId,
    };
}
