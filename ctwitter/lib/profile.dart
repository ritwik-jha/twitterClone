import 'dart:convert';

import 'package:ctwitter/apiFunctions.dart';
import 'package:ctwitter/heightFunctions.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<tweet> userTweetList = [];
  String name = "";
  String email = "";

  void populateTweetList() {
    fetchUserBlogs().then(
      (value) {
        if (value["response"]['message'] == 'success') {
          setState(() {
            for (Map i in value["response"]['data']) {
              bool liked = false;
              List j = jsonDecode(i["likedBy"]);
              j.forEach((element) {
                if (element == value["id"]) {
                  liked = true;
                }
              });
              userTweetList.add(tweet(
                likesCount: i["likesCount"],
                blogId: i["blogId"],
                author: i["userName"],
                content: i["content"],
                date: i["date"],
                liked: liked,
              ));
            }
            userTweetList = userTweetList.reversed.toList();
          });
        }
      },
    );
    // for (int i = 0; i < 10; i++) {
    //   userTweetList.add(tweet(
    //     author: "Ritwik",
    //     content: "Hello this is my post",
    //     date: "20 June",
    //   ));
    // }
  }

  void getUserDetails() {
    fetchUserDetails().then((value) {
      if (value['message'] == 'success') {
        setState(() {
          name = value['data']['username'];
          email = value['data']['email'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
    populateTweetList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: getHeight(118),
                width: getWidth(376),
                color: Colors.grey,
              ),
            ),
            Positioned(
              top: getHeight(130),
              left: getWidth(12),
              child: Container(
                height: getHeight(48),
                width: getHeight(48),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        BorderRadius.all(Radius.circular(getHeight(24)))),
              ),
            ),
            Positioned(
              top: getHeight(190),
              left: getWidth(12),
              child: Container(
                height: getHeight(100),
                width: getWidth(356),
                decoration: const BoxDecoration(
                  //color: Colors.yellow,
                  border: Border(
                    // top: BorderSide(
                    //   color: Color.fromRGBO(85, 90, 100, 1),
                    //   width: 0.5,
                    // ),
                    bottom: BorderSide(
                      color: Color.fromRGBO(85, 90, 100, 1),
                      width: 0.8,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: getHeight(10),
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: getHeight(260),
              left: getWidth(12),
              child: Container(
                  //color: Colors.yellow,
                  child: const Text(
                'Your Tweets',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
            Positioned(
                top: getHeight(300),
                left: getWidth(12),
                child: Container(
                    //color: Colors.yellow,
                    height: getHeight(407),
                    width: getWidth(356),
                    child: userTweetList.isEmpty
                        ? Container(
                            child: Center(
                              child: Text(
                                'No data to show!!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: userTweetList,
                              ),
                            ),
                          )))
          ],
        ),
      ),
    );
  }
}

class tweet extends StatefulWidget {
  String author;
  String content;
  String date;
  int blogId;
  int likesCount;
  bool liked;
  tweet(
      {required this.author,
      required this.content,
      required this.date,
      required this.blogId,
      required this.likesCount,
      required this.liked});

  @override
  State<tweet> createState() => _tweetState(
      author: this.author,
      content: this.content,
      date: this.date,
      blogId: this.blogId,
      likesCount: this.likesCount,
      liked: this.liked);
}

class _tweetState extends State<tweet> {
  String author;
  String content;
  String date;
  int blogId;
  bool liked;
  int likesCount;

  // void formatContent() {
  //   int count = 0;
  //   for (int i = 0; i < content.length; i++) {

  //   }
  // }

  _tweetState(
      {required this.author,
      required this.content,
      required this.date,
      required this.blogId,
      required this.likesCount,
      required this.liked});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          //color: Colors.yellow,
          border: Border(
              top: BorderSide(
        color: Color.fromRGBO(85, 90, 100, 1),
        width: 0.5,
      ))),
      height: content.length < 50
          ? getHeight(72 + 35)
          : getHeight(72 + 10 * (content.length / 50) + 35),
      width: getWidth(376),
      child: Stack(
        children: [
          Positioned(
            top: getHeight(12),
            left: getHeight(12),
            child: Container(
              height: getHeight(48),
              width: getHeight(48),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(getHeight(24))),
                  color: Color.fromRGBO(85, 90, 100, 1)),
            ),
          ),
          Positioned(
            top: getHeight(18),
            left: getWidth(70),
            child: Text(
              author,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'arial',
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            top: getHeight(18),
            left: getWidth(300),
            child: Text(
              date,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'arial',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            top: getHeight(38),
            left: getWidth(70),
            child: Container(
              //color: Colors.orange,
              width: getWidth(250),
              child: Text(
                content,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'arial',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: getHeight(22),
            left: getWidth(70),
            child: Container(
              height: 16,
              width: getWidth(255),
              //color: Colors.yellow,
              child: Row(
                children: [
                  liked
                      ? const Icon(
                          Icons.thumb_up,
                          color: Color.fromARGB(255, 11, 130, 234),
                          size: 18,
                        )
                      : InkWell(
                          onTap: () {
                            likePost(blogId).then((value) {
                              if (value["message"] == "success") {
                                setState(() {
                                  liked = true;
                                  likesCount++;
                                });
                              }
                            });
                          },
                          child: const Icon(
                            Icons.thumb_up,
                            color: Color.fromRGBO(85, 90, 100, 1),
                            size: 18,
                          ),
                        ),
                  SizedBox(
                    width: getWidth(10),
                  ),
                  Text(
                    likesCount.toString(),
                    style: const TextStyle(
                      color: Color.fromRGBO(85, 90, 100, 1),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: getWidth(26.74),
                  ),
                  const Icon(
                    Icons.reply_rounded,
                    color: Color.fromRGBO(85, 90, 100, 1),
                    size: 18,
                  ),
                  SizedBox(
                    width: getWidth(10),
                  ),
                  Text(
                    '.',
                    style: TextStyle(
                      color: Color.fromRGBO(85, 90, 100, 1),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: getWidth(26.74),
                  ),
                  const Icon(
                    Icons.restart_alt,
                    color: Color.fromRGBO(85, 90, 100, 1),
                    size: 18,
                  ),
                  SizedBox(
                    width: getWidth(10),
                  ),
                  Text(
                    '.',
                    style: TextStyle(
                      color: Color.fromRGBO(85, 90, 100, 1),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: getWidth(26.74),
                  ),
                  const Icon(
                    Icons.ios_share,
                    color: Color.fromRGBO(85, 90, 100, 1),
                    size: 18,
                  ),
                  SizedBox(
                    width: getWidth(10),
                  ),
                  Text(
                    '.',
                    style: TextStyle(
                      color: Color.fromRGBO(85, 90, 100, 1),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
