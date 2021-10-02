// To parse this JSON data, do
//
//     final subscriptionsaveuserdata = subscriptionsaveuserdataFromJson(jsonString);

class Subscriptionsaveuserdata {
  Subscriptionsaveuserdata({
    this.id,
    required this.subscriptionid,
    required this.startdate,
    required this.enddate,
    required this.status,
    required this.subscriptionpack,
    required this.remaining,
  });

  int? id;
  String subscriptionid;
  String startdate;
  String enddate;
  String status;
  String subscriptionpack;
  String remaining;

  factory Subscriptionsaveuserdata.fromMap(Map<String, dynamic> json) =>
      Subscriptionsaveuserdata(
        id: json["id"],
        subscriptionid: json['subscriptionid'],
        startdate: json["startdate"],
        enddate: json["enddate"],
        status: json["status"],
        subscriptionpack: json["subscriptionpack"],
        remaining: json["remaining"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "subscriptionid" : subscriptionid,
        "startdate": startdate,
        "enddate": enddate,
        "status": status,
        "subscriptionpack": subscriptionpack,
        "remaining": remaining,
      };
}
