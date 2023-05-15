import 'package:flutter/material.dart';
import 'package:twitter_app/data/datasources/tweet_datasource.dart';
import 'package:twitter_app/data/models/tweet_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameTextEditingContoller = TextEditingController();
  TextEditingController _nameTweetEditingContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: 600.0,
                        child: Column(
                          children: [
                            TextField(
                              controller: _nameTextEditingContoller,
                              decoration:
                                  const InputDecoration(hintText: "Name"),
                            ),
                            TextField(
                              controller: _nameTweetEditingContoller,
                              decoration:
                                  const InputDecoration(hintText: "Your Tweet"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                print("post a tweet");
                                String name = _nameTextEditingContoller.text;
                                String tweet = _nameTweetEditingContoller.text;

                                TweetModel tweetModel =
                                    TweetModel(writter: name, tweet: tweet);
                                await TweetDataSource.postTweet(tweetModel);
                              },
                              child: const Text("Post"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text("Post a tweet!"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text("Refresh"),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 10,
          child: FutureBuilder(
              future: TweetDataSource.getAllTweet(),
              builder: (BuildContext context, AsyncSnapshot sn) {
                if (sn.hasError) {
                  return const Text("Error Loading Data");
                }
                if (sn.hasData) {
                  List<TweetModel> tweets = sn.data;
                  return ListView.builder(
                    itemCount: tweets.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      leading: const CircleAvatar(
                        backgroundImage:
                            NetworkImage("https://i.pravatar.cc/300"),
                      ),
                      title: Text("${tweets[index].writter}"),
                      subtitle: Text("${tweets[index].tweet}"),
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ],
    );
  }
}
