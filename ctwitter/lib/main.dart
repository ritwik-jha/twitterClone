import 'package:ctwitter/compose.dart';
import 'package:ctwitter/homePage.dart';
import 'package:ctwitter/navBar.dart';
import 'package:ctwitter/profile.dart';
import 'package:ctwitter/search.dart';
import 'package:ctwitter/signin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  int id = 0;
  void _onTap(int index) {
    setState(() {
      print('intital index: $_currentIndex');
      _currentIndex = index;
      print('final index $_currentIndex');
    });
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void checkLoggedIn() async {
    final SharedPreferences pref = await _prefs;
    int? id1 = pref.getInt("id");

    if (id1 != null) {
      setState(() {
        id = id1;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //drawer: NavBar(),
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
        body: id == 0
            ? signin()
            : _currentIndex == 0
                ? Home()
                : _currentIndex == 1
                    ? compose()
                    : _currentIndex == 2
                        ? Search()
                        : _currentIndex == 3
                            ? Profile()
                            : Container(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  //color: Colors.white,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner
                    //color: Colors.white,
                    ),
                label: 'Compose'),
            BottomNavigationBarItem(
                icon: Icon(Icons.tag
                    //color: Colors.white,
                    ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person
                    //color: Colors.white,
                    ),
                label: 'Profile'),
          ],
          //fixedColor: Color.fromRGBO(0, 0, 0, 1),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: _onTap,
        ),
      ),
    );
  }
}
