import 'package:ctwitter/heightFunctions.dart';
import 'package:ctwitter/main.dart';
import 'package:flutter/material.dart';

class tweetSuccess extends StatefulWidget {
  const tweetSuccess({Key? key}) : super(key: key);

  @override
  State<tweetSuccess> createState() => _tweetSuccessState();
}

class _tweetSuccessState extends State<tweetSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                top: getHeight(200),
                left: getWidth(50),
                child: Container(
                  width: getWidth(300),
                  child: const Image(
                    image: AssetImage('assets/done.gif'),
                    fit: BoxFit.contain,
                  ),
                )),
            Positioned(
              top: getHeight(500),
              left: getWidth(50),
              child: const Text(
                "Tweeted Successfully",
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 130, 234),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              top: getHeight(650),
              left: getWidth(80),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromARGB(
                        255, 11, 130, 234), //Color.fromRGBO(12, 169, 150, 1),
                  ),
                  child: const Center(
                      child: Text(
                    'Go back',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
