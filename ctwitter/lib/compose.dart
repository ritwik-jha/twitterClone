import 'package:ctwitter/apiFunctions.dart';
import 'package:ctwitter/heightFunctions.dart';
import 'package:ctwitter/homePage.dart';
import 'package:ctwitter/main.dart';
import 'package:ctwitter/tweetSuccess.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class compose extends StatefulWidget {
  const compose({Key? key}) : super(key: key);

  @override
  State<compose> createState() => _composeState();
}

class _composeState extends State<compose> {
  String content = "";
  int? id = 0;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setId() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      id = prefs.getInt("id");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("What's happening?"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: getHeight(28),
            left: getWidth(299),
            child: InkWell(
              onTap: () {
                print(id);
                print(content);
                if (content != "" && id != 0) {
                  DateTime dateNow = DateTime.now();
                  String date =
                      "${dateNow.day.toString()} ${getMonth(dateNow.month).toString()}";
                  print(date);
                  createTweet(content, date, id).then((value) {
                    if (value['message'] == 'success') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => tweetSuccess()));
                    }
                  });
                }
              },
              child: Container(
                height: getHeight(36),
                width: getWidth(59),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromRGBO(74, 152, 233, 1),
                ),
                child: const Center(
                  child: Text(
                    'Tweet',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: getHeight(84),
              child: Container(
                height: getHeight(100),
                width: getWidth(376),
                //color: Colors.yellow,
                decoration: const BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border(
                    top: BorderSide(
                      color: Color.fromRGBO(85, 90, 100, 1),
                      width: 0.5,
                    ),
                    bottom: BorderSide(
                      color: Color.fromRGBO(85, 90, 100, 1),
                      width: 0.5,
                    ),
                  ),
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  cursorColor: const Color.fromRGBO(74, 152, 233, 1),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    content = value;
                  },
                ),
              ))
        ],
      ),
    );
  }
}
