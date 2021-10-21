// To parse this JSON data, do
//
//     final mcqpostlist = mcqpostlistFromJson(jsonString);

import 'dart:convert';

List<Mcqpostlist> mcqpostlistFromJson(String str) => List<Mcqpostlist>.from(json.decode(str).map((x) => Mcqpostlist.fromJson(x)));

String mcqpostlistToJson(List<Mcqpostlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mcqpostlist {
    Mcqpostlist({
        this.id,
        this.link,
        this.title,
        this.yoastHeadJson,
    });

    int? id;
    String? link;
    Title? title;
    YoastHeadJson? yoastHeadJson;

    factory Mcqpostlist.fromJson(Map<String, dynamic> json) => Mcqpostlist(
        id: json["id"],
        link: json["link"],
        title: Title.fromJson(json["title"]),
        yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "title": title!.toJson(),
        "yoast_head_json": yoastHeadJson!.toJson(),
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
        this.type,
    });

    int? width;
    int? height;
    String? url;
    String? type;

    factory OgImage.fromJson(Map<String, dynamic> json) => OgImage(
        width: json["width"],
        height: json["height"],
        url: json["url"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "url": url,
        "type": type,
    };
}
