import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitter_app/data/models/tweet_model.dart';

class TweetDataSource {
  static Future<List> getAllTweet() async {
    List<TweetModel> tweetlist = [];

    http.Response response = await http.get(
      Uri.parse("https://645b8ecea8f9e4d6e76be10c.mockapi.io/tweet"),
    );

    if (response.statusCode == 200) {
      List parsedJson = jsonDecode(response.body);

      parsedJson.forEach((tweet) {
        TweetModel tweetModel = TweetModel.fromJason(tweet);
        tweetlist.add(tweetModel);
      });
    }
    return tweetlist;
  }

  static Future<bool> postTweet(TweetModel tweetModel) async {
    http.Response response = await http.post(
      Uri.parse("https://645b8ecea8f9e4d6e76be10c.mockapi.io/tweet"),
      body: tweetModel.toJson(),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
