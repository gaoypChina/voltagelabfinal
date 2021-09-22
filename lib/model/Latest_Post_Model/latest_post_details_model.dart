// To parse this JSON data, do
//
//     final latestPostData = latestPostDataFromJson(jsonString);

import 'dart:convert';

LatestPostdetails latestPostDetailsFromJson(String str) => LatestPostdetails.fromJson(json.decode(str));

String latestPostDetailsToJson(LatestPostdetails data) => json.encode(data.toJson());

class LatestPostdetails {
    LatestPostdetails({
        required this.link,
        required this.content,
        required this.links,
    });

    String link;
    Content content;
    Links links;

    factory LatestPostdetails.fromJson(Map<String, dynamic> json) => LatestPostdetails(
        link: json["link"],
        content: Content.fromJson(json["content"]),
        links: Links.fromJson(json["_links"]),
    );

    Map<String, dynamic> toJson() => {
        "link": link,
        "content": content.toJson(),
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
        required this.self,
        required this.collection,
        required this.about,
        required this.author,
        required this.replies,
        required this.versionHistory,
        required this.predecessorVersion,
        required this.wpFeaturedmedia,
        required this.wpAttachment,
        required this.wpTerm,
        required this.curies,
    });

    List<About> self;
    List<About> collection;
    List<About> about;
    List<Author> author;
    List<Author> replies;
    List<VersionHistory> versionHistory;
    List<PredecessorVersion> predecessorVersion;
    List<Author> wpFeaturedmedia;
    List<About> wpAttachment;
    List<WpTerm> wpTerm;
    List<Cury> curies;

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
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
        "version-history": List<dynamic>.from(versionHistory.map((x) => x.toJson())),
        "predecessor-version": List<dynamic>.from(predecessorVersion.map((x) => x.toJson())),
        "wp:featuredmedia": List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
        "wp:attachment": List<dynamic>.from(wpAttachment.map((x) => x.toJson())),
        "wp:term": List<dynamic>.from(wpTerm.map((x) => x.toJson())),
        "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
    };
}

class About {
    About({
        required this.href,
    });

    String href;

    factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
    };
}

class Author {
    Author({
        required this.embeddable,
        required this.href,
    });

    bool embeddable;
    String href;

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
        required this.name,
        required this.href,
        required this.templated,
    });

    String name;
    String href;
    bool templated;

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
        required this.id,
        required this.href,
    });

    int id;
    String href;

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
        required this.count,
        required this.href,
    });

    int count;
    String href;

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
        required this.taxonomy,
        required this.embeddable,
        required this.href,
    });

    String taxonomy;
    bool embeddable;
    String href;

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
