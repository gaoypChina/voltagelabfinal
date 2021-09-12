// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
    Categories({
        this.id,
        this.count,
        this.description,
        this.link,
        this.name,
        this.slug,
        this.taxonomy,
        this.parent,
        this.meta,
        this.yoastHead,
        this.yoastHeadJson,
        this.links,
    });

    int? id;
    int? count;
    String? description;
    String? link;
    String? name;
    String? slug;
    String? taxonomy;
    int? parent;
    List<dynamic>? meta;
    String? yoastHead;
    YoastHeadJson? yoastHeadJson;
    Links? links;

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        count: json["count"],
        description: json["description"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
        taxonomy: json["taxonomy"],
        parent: json["parent"],
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
        yoastHead: json["yoast_head"],
        yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
        links: Links.fromJson(json["_links"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "description": description,
        "link": link,
        "name": name,
        "slug": slug,
        "taxonomy": taxonomy,
        "parent": parent,
        "meta": List<dynamic>.from(meta!.map((x) => x)),
        "yoast_head": yoastHead,
        "yoast_head_json": yoastHeadJson!.toJson(),
        "_links": links!.toJson(),
    };
}

class Links {
    Links({
        this.self,
        this.collection,
        this.about,
        this.wpPostType,
        this.curies,
    });

    List<About>? self;
    List<About>? collection;
    List<About>? about;
    List<About>? wpPostType;
    List<Cury>? curies;

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        wpPostType: List<About>.from(json["wp:post_type"].map((x) => About.fromJson(x))),
        curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self!.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection!.map((x) => x.toJson())),
        "about": List<dynamic>.from(about!.map((x) => x.toJson())),
        "wp:post_type": List<dynamic>.from(wpPostType!.map((x) => x.toJson())),
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

class YoastHeadJson {
    YoastHeadJson({
        this.robots,
        this.canonical,
        this.ogLocale,
        this.ogType,
        this.ogTitle,
        this.ogUrl,
        this.ogSiteName,
        this.twitterCard,
        this.twitterSite,
        this.schema,
    });

    Robots? robots;
    String? canonical;
    String? ogLocale;
    String? ogType;
    String? ogTitle;
    String? ogUrl;
    String? ogSiteName;
    String? twitterCard;
    String? twitterSite;
    Schema? schema;

    factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
        robots: Robots.fromJson(json["robots"]),
        canonical: json["canonical"],
        ogLocale: json["og_locale"],
        ogType: json["og_type"],
        ogTitle: json["og_title"],
        ogUrl: json["og_url"],
        ogSiteName: json["og_site_name"],
        twitterCard: json["twitter_card"],
        twitterSite: json["twitter_site"],
        schema: Schema.fromJson(json["schema"]),
    );

    Map<String, dynamic> toJson() => {
        "robots": robots!.toJson(),
        "canonical": canonical,
        "og_locale": ogLocale,
        "og_type": ogType,
        "og_title": ogTitle,
        "og_url": ogUrl,
        "og_site_name": ogSiteName,
        "twitter_card": twitterCard,
        "twitter_site": twitterSite,
        "schema": schema!.toJson(),
    };
}

class Robots {
    Robots({
        this.index,
        this.follow,
        this.maxSnippet,
        this.maxImagePreview,
        this.maxVideoPreview,
    });

    String? index;
    String? follow;
    String? maxSnippet;
    String? maxImagePreview;
    String? maxVideoPreview;

    factory Robots.fromJson(Map<String, dynamic> json) => Robots(
        index: json["index"],
        follow: json["follow"],
        maxSnippet: json["max-snippet"],
        maxImagePreview: json["max-image-preview"],
        maxVideoPreview: json["max-video-preview"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "follow": follow,
        "max-snippet": maxSnippet,
        "max-image-preview": maxImagePreview,
        "max-video-preview": maxVideoPreview,
    };
}

class Schema {
    Schema({
        this.context,
        this.graph,
    });

    String? context;
    List<Graph>? graph;

    factory Schema.fromJson(Map<String, dynamic> json) => Schema(
        context: json["@context"],
        graph: List<Graph>.from(json["@graph"].map((x) => Graph.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "@context": context,
        "@graph": List<dynamic>.from(graph!.map((x) => x.toJson())),
    };
}

class Graph {
    Graph({
        this.type,
        this.id,
        this.name,
        this.url,
        this.sameAs,
        this.logo,
        this.image,
        this.description,
        this.publisher,
        this.potentialAction,
        this.inLanguage,
        this.isPartOf,
        this.breadcrumb,
        this.itemListElement,
    });

    String? type;
    String? id;
    String? name;
    String? url;
    List<String>? sameAs;
    Logo? logo;
    Breadcrumb? image;
    String? description;
    Breadcrumb? publisher;
    List<PotentialAction>? potentialAction;
    String? inLanguage;
    Breadcrumb? isPartOf;
    Breadcrumb? breadcrumb;
    List<ItemListElement>? itemListElement;

    factory Graph.fromJson(Map<String, dynamic> json) => Graph(
        type: json["@type"],
        id: json["@id"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
        sameAs: json["sameAs"] == null ? null : List<String>.from(json["sameAs"].map((x) => x)),
        logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
        image: json["image"] == null ? null : Breadcrumb.fromJson(json["image"]),
        description: json["description"] == null ? null : json["description"],
        publisher: json["publisher"] == null ? null : Breadcrumb.fromJson(json["publisher"]),
        potentialAction: json["potentialAction"] == null ? null : List<PotentialAction>.from(json["potentialAction"].map((x) => PotentialAction.fromJson(x))),
        inLanguage: json["inLanguage"] == null ? null : json["inLanguage"],
        isPartOf: json["isPartOf"] == null ? null : Breadcrumb.fromJson(json["isPartOf"]),
        breadcrumb: json["breadcrumb"] == null ? null : Breadcrumb.fromJson(json["breadcrumb"]),
        itemListElement: json["itemListElement"] == null ? null : List<ItemListElement>.from(json["itemListElement"].map((x) => ItemListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "@id": id,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "sameAs": sameAs == null ? null : List<dynamic>.from(sameAs!.map((x) => x)),
        "logo": logo == null ? null : logo!.toJson(),
        "image": image == null ? null : image!.toJson(),
        "description": description == null ? null : description,
        "publisher": publisher == null ? null : publisher!.toJson(),
        "potentialAction": potentialAction == null ? null : List<dynamic>.from(potentialAction!.map((x) => x.toJson())),
        "inLanguage": inLanguage == null ? null : inLanguage,
        "isPartOf": isPartOf == null ? null : isPartOf!.toJson(),
        "breadcrumb": breadcrumb == null ? null : breadcrumb!.toJson(),
        "itemListElement": itemListElement == null ? null : List<dynamic>.from(itemListElement!.map((x) => x.toJson())),
    };
}

class Breadcrumb {
    Breadcrumb({
        this.id,
    });

    String? id;

    factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
        id: json["@id"],
    );

    Map<String, dynamic> toJson() => {
        "@id": id,
    };
}

class ItemListElement {
    ItemListElement({
        this.type,
        this.position,
        this.name,
        this.item,
    });

    String? type;
    int? position;
    String? name;
    String? item;

    factory ItemListElement.fromJson(Map<String, dynamic> json) => ItemListElement(
        type: json["@type"],
        position: json["position"],
        name: json["name"],
        item: json["item"] == null ? null : json["item"],
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "position": position,
        "name": name,
        "item": item == null ? null : item,
    };
}

class Logo {
    Logo({
        this.type,
        this.id,
        this.inLanguage,
        this.url,
        this.contentUrl,
        this.caption,
    });

    String? type;
    String? id;
    String? inLanguage;
    String? url;
    String? contentUrl;
    String? caption;

    factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        type: json["@type"],
        id: json["@id"],
        inLanguage: json["inLanguage"],
        url: json["url"],
        contentUrl: json["contentUrl"],
        caption: json["caption"],
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "@id": id,
        "inLanguage": inLanguage,
        "url": url,
        "contentUrl": contentUrl,
        "caption": caption,
    };
}

class PotentialAction {
    PotentialAction({
        this.type,
        this.target,
        this.queryInput,
    });

    String? type;
    dynamic target;
    String? queryInput;

    factory PotentialAction.fromJson(Map<String, dynamic> json) => PotentialAction(
        type: json["@type"],
        target: json["target"],
        queryInput: json["query-input"] == null ? null : json["query-input"],
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "target": target,
        "query-input": queryInput == null ? null : queryInput,
    };
}

class TargetClass {
    TargetClass({
        this.type,
        this.urlTemplate,
    });

    String? type;
    String? urlTemplate;

    factory TargetClass.fromJson(Map<String, dynamic> json) => TargetClass(
        type: json["@type"],
        urlTemplate: json["urlTemplate"],
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "urlTemplate": urlTemplate,
    };
}
