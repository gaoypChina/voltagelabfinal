// To parse this JSON data, do
//
//     final latestPostData = latestPostDataFromJson(jsonString);

import 'dart:convert';

List<LatestPostData> latestPostDataFromJson(String str) => List<LatestPostData>.from(json.decode(str).map((x) => LatestPostData.fromJson(x)));

String latestPostDataToJson(List<LatestPostData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LatestPostData {
    LatestPostData({
        required this.id,
        required this.title,
        required this.yoastHeadJson,
    });

    int id;
    Title title;
    YoastHeadJson yoastHeadJson;

    factory LatestPostData.fromJson(Map<String, dynamic> json) => LatestPostData(
        id: json["id"],
        title: Title.fromJson(json["title"]),
        yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "yoast_head_json": yoastHeadJson.toJson(),
    };
}

class Title {
    Title({
        required this.rendered,
    });

    String rendered;

    factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
    };
}

class YoastHeadJson {
    YoastHeadJson({
        required this.ogImage,
    });

    List<OgImage> ogImage;

    factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
        ogImage: List<OgImage>.from(json["og_image"].map((x) => OgImage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "og_image": List<dynamic>.from(ogImage.map((x) => x.toJson())),
    };
}

class OgImage {
    OgImage({
        required this.width,
        required this.height,
        required this.url,
        required this.path,
        required this.size,
        required this.id,
        required this.alt,
        required this.pixels,
        required this.type,
    });

    int width;
    int height;
    String url;
    String path;
    String size;
    int id;
    String alt;
    int pixels;
    String type;

    factory OgImage.fromJson(Map<String, dynamic> json) => OgImage(
        width: json["width"],
        height: json["height"],
        url: json["url"],
        path: json["path"],
        size: json["size"],
        id: json["id"],
        alt: json["alt"],
        pixels: json["pixels"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "url": url,
        "path": path,
        "size": size,
        "id": id,
        "alt": alt,
        "pixels": pixels,
        "type": type,
    };
}
