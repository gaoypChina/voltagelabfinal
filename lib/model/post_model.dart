// To parse this JSON data, do
//
//     final postdata = postdataFromJson(jsonString);

import 'dart:convert';

List<Postdata> postdataFromJson(String str) => List<Postdata>.from(json.decode(str).map((x) => Postdata.fromJson(x)));

String postdataToJson(List<Postdata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Postdata {
    Postdata({
         this.id,
         this.title,
         this.yoastHeadJson,
    });

    int? id;
    Title? title;
    YoastHeadJson? yoastHeadJson;

    factory Postdata.fromJson(Map<String, dynamic> json) => Postdata(
        id: json["id"],
        title: Title.fromJson(json["title"]),
        yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title!.toJson(),
        "yoast_head_json": yoastHeadJson!.toJson(),
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
         this.width,
         this.height,
         this.url,
         this.path,
         this.size,
         this.id,
         this.alt,
         this.pixels,
         this.type,
    });

    int? width;
    int? height;
    String? url;
    String? path;
    String? size;
    int? id;
    String? alt;
    int? pixels;
    String? type;

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
