// To parse this JSON data, do
//
//     final searchPostDetails = searchPostDetailsFromJson(jsonString);

import 'dart:convert';

SearchPostDetails searchPostDetailsFromJson(String str) => SearchPostDetails.fromJson(json.decode(str));

String searchPostDetailsToJson(SearchPostDetails data) => json.encode(data.toJson());

class SearchPostDetails {
    SearchPostDetails({
        required this.id,
        required this.link,
        required this.title,
        required this.content,
        required this.yoastHeadJson,
        required this.links,
    });

    int id;
    String link;
    Title title;
    Content content;
    YoastHeadJson yoastHeadJson;
    Links links;

    factory SearchPostDetails.fromJson(Map<String, dynamic> json) => SearchPostDetails(
        id: json["id"],
        link: json["link"],
        title: Title.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
        yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
        links: Links.fromJson(json["_links"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "title": title.toJson(),
        "content": content.toJson(),
        "yoast_head_json": yoastHeadJson.toJson(),
        "_links": links.toJson(),
    };
}

class Content {
    Content({
        required this.rendered,
        required this.protected,
    });

    String rendered;
    bool protected;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
    );

    Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
    };
}

class Links {
    Links({
        this.self,
        this.collection,
        this.about,
        this.author,
        this.replies,
        this.versionHistory,
        this.predecessorVersion,
        this.wpFeaturedmedia,
        this.wpAttachment,
        this.wpTerm,
        this.curies,
    });

    List<About>? self;
    List<About>? collection;
    List<About>? about;
    List<Author>? author;
    List<Author>? replies;
    List<VersionHistory>? versionHistory;
    List<PredecessorVersion>? predecessorVersion;
    List<Author>? wpFeaturedmedia;
    List<About>? wpAttachment;
    List<WpTerm>? wpTerm;
    List<Cury>? curies;

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        author: List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        replies: List<Author>.from(json["replies"].map((x) => Author.fromJson(x))),
        versionHistory: List<VersionHistory>.from(json["version-history"].map((x) => VersionHistory.fromJson(x))),
        predecessorVersion: List<PredecessorVersion>.from(json["predecessor-version"].map((x) => PredecessorVersion.fromJson(x))),
        wpFeaturedmedia: List<Author>.from(json["wp:featuredmedia"].map((x) => Author.fromJson(x))),
        wpAttachment: List<About>.from(json["wp:attachment"].map((x) => About.fromJson(x))),
        wpTerm: List<WpTerm>.from(json["wp:term"].map((x) => WpTerm.fromJson(x))),
        curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
        "about": List<dynamic>.from(about!.map((x) => x.toJson())),
        "author": List<dynamic>.from(author!.map((x) => x.toJson())),
        "replies": List<dynamic>.from(replies!.map((x) => x.toJson())),
        "version-history": List<dynamic>.from(versionHistory!.map((x) => x.toJson())),
        "predecessor-version": List<dynamic>.from(predecessorVersion!.map((x) => x.toJson())),
        "wp:featuredmedia": List<dynamic>.from(wpFeaturedmedia!.map((x) => x.toJson())),
        "wp:attachment": List<dynamic>.from(wpAttachment!.map((x) => x.toJson())),
        "wp:term": List<dynamic>.from(wpTerm!.map((x) => x.toJson())),
        "curies": List<dynamic>.from(curies!.map((x) => x.toJson())),
    };
}

class About {
    About({
        this.href,
    });

    String? href;

    factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
    };
}

class Author {
    Author({
        this.embeddable,
        this.href,
    });

    bool? embeddable;
    String? href;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        embeddable: json["embeddable"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "embeddable": embeddable,
        "href": href,
    };
}

class Cury {
    Cury({
        this.name,
        this.href,
        this.templated,
    });

    String? name;
    String? href;
    bool? templated;

    factory Cury.fromJson(Map<String, dynamic> json) => Cury(
        name: json["name"],
        href: json["href"],
        templated: json["templated"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "href": href,
        "templated": templated,
    };
}

class PredecessorVersion {
    PredecessorVersion({
        this.id,
        this.href,
    });

    int? id;
    String? href;

    factory PredecessorVersion.fromJson(Map<String, dynamic> json) => PredecessorVersion(
        id: json["id"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "href": href,
    };
}

class VersionHistory {
    VersionHistory({
        this.count,
        this.href,
    });

    int? count;
    String? href;

    factory VersionHistory.fromJson(Map<String, dynamic> json) => VersionHistory(
        count: json["count"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "href": href,
    };
}

class WpTerm {
    WpTerm({
        this.taxonomy,
        this.embeddable,
        this.href,
    });

    String? taxonomy;
    bool? embeddable;
    String? href;

    factory WpTerm.fromJson(Map<String, dynamic> json) => WpTerm(
        taxonomy: json["taxonomy"],
        embeddable: json["embeddable"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "taxonomy": taxonomy,
        "embeddable": embeddable,
        "href": href,
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
        // required this.width,
        // required this.height,
        required this.url,
        // required this.path,
        // required this.size,
        // required this.id,
        // required this.alt,
        // required this.pixels,
        // required this.type,
    });

    // int width;
    // int height;
    String url;
    // String path;
    // String size;
    // int id;
    // String alt;
    // int pixels;
    // String type;

    factory OgImage.fromJson(Map<String, dynamic> json) => OgImage(
        // width: json["width"],
        // height: json["height"],
        url: json["url"],
        // path: json["path"],
        // size: json["size"],
        // id: json["id"],
        // alt: json["alt"],
        // pixels: json["pixels"],
        // type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        // "width": width,
        // "height": height,
        "url": url,
        // "path": path,
        // "size": size,
        // "id": id,
        // "alt": alt,
        // "pixels": pixels,
        // "type": type,
    };
}
