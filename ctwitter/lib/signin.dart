import 'package:ctwitter/apiFunctions.dart';
import 'package:ctwitter/heightFunctions.dart';
import 'package:ctwitter/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  late String email;
  late String pass;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> setId(int id) async {
    final SharedPreferences pref = await _prefs;

    return pref.setInt("id", id);
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.black, //Color.fromRGBO(16, 29, 37, 1),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getHeight(100),
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    //color: Color.fromRGBO(12, 169, 150, 1),
                    color: Color.fromARGB(255, 11, 130, 234),
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: getHeight(100),
                ),
                Container(
                  // margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      //color: Color.fromRGBO(12, 169, 150, 1),
                      color: Colors.white),
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 11, 130, 234),
                        ),
                        hintText: 'Your email address?',
                        labelText: 'Email *',
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(50),
                ),
                Container(
                  // margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    //color: Color.fromRGBO(12, 169, 150, 1),
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.password,
                          color: Color.fromARGB(255, 11, 130, 234),
                        ),
                        hintText: 'Password',
                        labelText: 'Password *',
                      ),
                      onChanged: (value) {
                        pass = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(100),
                ),
                TextButton(
                  onPressed: () async {
                    signIn(email, pass).then((value) {
                      if (value["message"] == "success") {
                        //print(value["id"].runtimeType);
                        int id = value["id"];
                        setId(id).then((value) {
                          if (value == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          }
                        });
                      } else {
                        Toast.show(value['data'],
                            duration: Toast.lengthShort, gravity: Toast.bottom);
                      }
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromARGB(
                          255, 11, 130, 234), //Color.fromRGBO(12, 169, 150, 1),
                    ),
                    child: const Center(
                        child: Text(
                      'Click here to login',
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                ),
                SizedBox(
                  height: getHeight(20),
                ),
                Container(
                  child: const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black, //Color.fromARGB(255, 0, 255, 225)
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // print(MediaQuery.of(context).size.height);
                    // print(MediaQuery.of(context).size.width);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromARGB(255, 11, 130,
                          234), //Color.fromARGB(255, 0, 255, 225),
                    ),
                    child: const Center(
                        child: Text(
                      'Click here to Signup',
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String email;
  late String pass;
  late String username;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> setId(int id) async {
    final SharedPreferences pref = await _prefs;

    return pref.setInt("id", id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black, //Color.fromRGBO(16, 29, 37, 1),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getHeight(100),
                ),
                const Text(
                  'Signup',
                  style: TextStyle(
                    //color: Color.fromRGBO(12, 169, 150, 1),
                    color: Color.fromARGB(255, 11, 130, 234),
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: getHeight(100),
                ),
                Container(
                  // margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    //color: Color.fromRGBO(12, 169, 150, 1),
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.password,
                          //color: Color.fromRGBO(157, 165, 172, 1),
                        ),
                        hintText: 'Enter your username',
                        labelText: 'Username *',
                      ),
                      onChanged: (value) {
                        username = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(50),
                ),
                Container(
                  // margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      //color: Color.fromRGBO(12, 169, 150, 1),
                      color: Colors.white),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.email,
                          //color: Color.fromRGBO(157, 165, 172, 1),
                        ),
                        hintText: 'Your email address?',
                        labelText: 'Email *',
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(50),
                ),
                Container(
                  // margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    //color: Color.fromRGBO(12, 169, 150, 1),
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.password,
                          //color: Color.fromRGBO(157, 165, 172, 1),
                        ),
                        hintText: 'Enter your password',
                        labelText: 'Password *',
                      ),
                      onChanged: (value) {
                        pass = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(120),
                ),
                TextButton(
                  onPressed: () {
                    if (username != "" && email != "" && pass != "") {
                      signUp(username, email, pass).then((value) {
                        if (value['message'] == 'success') {
                          setId(value["id"]).then((value) {
                            if (value == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()));
                            }
                          });
                        } else {
                          // Toast.show(value.toString(),
                          //     duration: Toast.lengthShort,
                          //     gravity: Toast.bottom);
                          print(value.toString());
                        }
                      });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromARGB(
                          255, 11, 130, 234), //Color.fromRGBO(12, 169, 150, 1),
                    ),
                    child: const Center(
                        child: Text(
                      'Click here to create account',
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
