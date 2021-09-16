// To parse this JSON data, do
//
//     final searchPost = searchPostFromJson(jsonString);

import 'dart:convert';

List<SearchPost> searchPostFromJson(String str) => List<SearchPost>.from(json.decode(str).map((x) => SearchPost.fromJson(x)));

String searchPostToJson(List<SearchPost> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchPost {
    SearchPost({
        required this.id,
        required this.title,
    });

    int id;
    String title;

    factory SearchPost.fromJson(Map<String, dynamic> json) => SearchPost(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}
