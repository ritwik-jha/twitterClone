import 'package:ctwitter/heightFunctions.dart';
import 'package:ctwitter/navBar.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Widget> storiesList = [];
  void populateStoriesList() {
    for (int i = 0; i < 5; i++) {
      storiesList.add(Stories());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    populateStoriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('Search')),
      ),
      // drawer: NavBar(),
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: getHeight(10),
              left: getWidth(20),
              child: Container(
                height: getHeight(35),
                width: getWidth(332),
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: const Center(
                  child: Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: getHeight(70),
              left: getWidth(10),
              child: Container(
                padding: EdgeInsets.all(getHeight(12)),
                height: getHeight(80),
                width: getWidth(356),
                // color: Colors.yellow,
                decoration: const BoxDecoration(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Trending',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: getHeight(4),
                    ),
                    const Text(
                      "What's new",
                      style: TextStyle(
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
              top: getHeight(184),
              left: getWidth(10),
              child: const Text(
                'Top Stories',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(85, 90, 100, 1)),
              ),
            ),
            Positioned(
              top: getHeight(220),
              left: getWidth(10),
              child: Container(
                //color: Colors.yellow,
                height: getHeight(464),
                width: getWidth(356),
                child: ListView(
                  children: storiesList,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Stories extends StatefulWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: getHeight(220),
          width: getWidth(356),
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Center(
            child: Text(
              'Storey goes here',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: getHeight(20),
        )
      ],
    );
  }
}
