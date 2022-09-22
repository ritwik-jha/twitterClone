import 'dart:convert';

import 'package:ctwitter/apiFunctions.dart';
import 'package:ctwitter/heightFunctions.dart';
import 'package:ctwitter/navBar.dart';
import 'package:ctwitter/signin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //int? id;

  List<tweet> tweetList = [];
  void populateList() {
    fetchAllBlogs().then((value) {
      //print(value);
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
            tweetList.add(tweet(
              likesCount: i["likesCount"],
              blogId: i["blogId"],
              author: i["userName"],
              content: i["content"],
              date: i["date"],
              liked: liked,
            ));
          }
          tweetList = tweetList.reversed.toList();
        });
      }
    });
    // for (int i = 0; i < 5; i++) {
    //   tweetList.add(tweet(
    //     author: "Ritwik",
    //     content: "Hello this is my post ......................... ",
    //     date: "20 June",
    //   ));
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    populateList();
  }

  @override
  Widget build(BuildContext context) {
    //populateList();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            SizedBox(
              width: getWidth(100),
            ),
            SizedBox(
              height: getHeight(35),
              width: getWidth(35),
              child: const Image(
                image: AssetImage('assets/twitter.png'),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const signin()));
            },
            child: SizedBox(
                height: getHeight(24),
                width: getWidth(24),
                child: const Icon(
                  Icons.drafts,
                  color: Colors.white,
                )),
          )
        ],
      ),
      drawer: NavBar(),
      body: SafeArea(
        minimum: EdgeInsets.all(getWidth(12)),
        child: tweetList.isEmpty
            ? Container(
                child: const Center(
                  child: Text(
                    'No data to show!!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: getHeight(12),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: tweetList,
                      ),
                    ),
                  )
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
  int likesCount;
  bool liked;

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
                  color: const Color.fromRGBO(85, 90, 100, 1)),
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
                  const Text(
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
                  const Text(
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
                  const Text(
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
