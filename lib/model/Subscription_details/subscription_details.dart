// To parse this JSON data, do
//
//     final subscriptionDetails = subscriptionDetailsFromJson(jsonString);

import 'dart:convert';

SubscriptionDetails subscriptionDetailsFromJson(String str) =>
    SubscriptionDetails.fromJson(json.decode(str));

String subscriptionDetailsToJson(SubscriptionDetails data) =>
    json.encode(data.toJson());

class SubscriptionDetails {
  SubscriptionDetails({
    this.content,
  });

  Content? content;

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) =>
      SubscriptionDetails(
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "content": content!.toJson(),
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
