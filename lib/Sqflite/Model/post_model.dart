// To parse this JSON data, do
//
//     final savepost = savepostFromJson(jsonString);

class Savepost {
    Savepost({
        this.id,
        required this.postid,
        required this.categoryid,
        required this.posttitle,
        required this.postdate,
        required this.postlink,
        required this.postcontent,
        required this.postimage,
    });

    int? id;
    int postid;
    int categoryid;
    String posttitle;
    String postdate;
    String postlink;
    String postcontent;
    String postimage;

    factory Savepost.fromMap(Map<String, dynamic> json) => Savepost(
        id: json["id"],
        postid: json["postid"],
        categoryid: json["categoryid"],
        posttitle: json["posttitle"],
        postdate: json["postdate"],
        postlink: json["postlink"],
        postcontent: json["postcontent"],
        postimage: json["postimage"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "postid": postid,
        "categoryid": categoryid,
        "posttitle": posttitle,
        "postdate": postdate,
        "postlink": postlink,
        "postcontent": postcontent,
        "postimage": postimage,
    };
}
