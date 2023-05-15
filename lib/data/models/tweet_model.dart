class TweetModel {
  int? id;
  String? writter;
  String? tweet;
  String? postedAt;

  TweetModel({this.id, this.writter, this.tweet, this.postedAt});

  TweetModel.fromJason(Map json) {
    id = int.parse(json["id"]);
    writter = json["author"];
    tweet = json["body"];
    postedAt = json["posted_at"];
  }

  Map<String, String> toJson() {
    Map<String, String> data = {};
    data["author"] = writter ?? "annon user";
    data["body"] = tweet ?? "Empty";
    return data;

    // return {"author": "$writter", "body": "$tweet"};
  }
}
