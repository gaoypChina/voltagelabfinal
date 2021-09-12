// To parse this JSON data, do
//
//     final postdata = postdataFromJson(jsonString);

import 'dart:convert';

List<Postdata> postdataFromJson(String str) => List<Postdata>.from(json.decode(str).map((x) => Postdata.fromJson(x)));

String postdataToJson(List<Postdata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Postdata {
    Postdata({
        this.id,
        this.date,
        this.title,
        this.content,
        this.yoastHeadJson,
    });

    int? id;
    DateTime? date;
    Title? title;
    Content? content;
    YoastHeadJson? yoastHeadJson;

    factory Postdata.fromJson(Map<String, dynamic> json) => Postdata(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        title: Title.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date!.toIso8601String(),
        "title": title!.toJson(),
        "content": content!.toJson(),
        "yoast_head_json": yoastHeadJson!.toJson(),
    };
}

class Content {
    Content({
        this.rendered,
        this.protected,
    });

    String? rendered;
    bool? protected;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
    };
}

class Title {
    Title({
        this.rendered,
    });

    String? rendered;

    factory Title.fromJson(Map<String, dynamic> json) => Title(
        rendered: json["rendered"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
    };
}

class YoastHeadJson {
    YoastHeadJson({
        this.ogImage,
    });

    List<OgImage>? ogImage;

    factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
        ogImage: List<OgImage>.from(json["og_image"].map((x) => OgImage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "og_image": List<dynamic>.from(ogImage!.map((x) => x.toJson())),
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
