import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String uriBase = "http://10.0.2.2:8000";
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//call to login the user
Future<Map> signIn(String email, String password) async {
  Uri url = Uri.parse("$uriBase/userAuth/userLogin/");

  var body = jsonEncode({"email": email, "password": password});

  var response = await http.post(url, body: body);

  Map finalResponse = jsonDecode(response.body);

  return finalResponse;
}

Future<Map> signUp(String username, String email, String password) async {
  Uri url = Uri.parse("$uriBase/userAuth/userSignup/");

  var body =
      jsonEncode({"email": email, "username": username, "password": password});

  var response = await http.post(url, body: body);

  Map finalResponse = jsonDecode(response.body);

  return finalResponse;
}

//call to fetch all the blogs in the database
Future<Map> fetchAllBlogs() async {
  Uri uri = Uri.parse("$uriBase/blogs/viewBlogs");
  SharedPreferences prefs = await _prefs;

  int? id = prefs.getInt("id");

  var response = await http.get(uri);

  //print(jsonDecode(response.body));

  Map finalResponse = jsonDecode(response.body);

  return {"response": finalResponse, "id": id};
}

// call to fetch the blogs authored by the current user
Future<Map> fetchUserBlogs() async {
  SharedPreferences prefs = await _prefs;

  int? id = prefs.getInt("id");

  Uri url = Uri.parse("$uriBase/blogs/filterBlogs/");

  var body = jsonEncode({"id": id});

  var response = await http.post(url, body: body);

  Map finalResponse = jsonDecode(response.body);

  return {"response": finalResponse, "id": id};
}

// call to fetch details of the current user
Future<Map> fetchUserDetails() async {
  SharedPreferences prefs = await _prefs;

  int? id = prefs.getInt("id");
  Uri url = Uri.parse("$uriBase/userAuth/userData/");

  var body = jsonEncode({"id": id});

  var response = await http.post(url, body: body);

  Map finalResponse = jsonDecode(response.body);

  return finalResponse;
}

Future<Map> getUsername(int id) async {
  Uri url = Uri.parse("$uriBase/blogs/returnUsername/");

  var body = jsonEncode({"id": id});

  var response = await http.post(url, body: body);

  Map finalResponse = jsonDecode(response.body);

  return finalResponse;
}

Future<Map> createTweet(String content, String date, int? id) async {
  Uri url = Uri.parse("$uriBase/blogs/viewBlogs/");

  var body = jsonEncode({
    "id": id,
    "content": content,
    "date": date,
  });

  var response = await http.post(url, body: body);

  Map finalResponse = jsonDecode(response.body);

  return finalResponse;
}

String getMonth(int i) {
  List<String> months = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'june',
    'july',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  return months[i - 1];
}

// Future<Map> fetchUserDetails() async {
//   SharedPreferences prefs = await _prefs;

//   int? id = prefs.getInt("id");

//   Uri url = Uri.parse("$uriBase/userAuth/userData/");

//   var body = jsonEncode({
//     "id": id
//   });

//   var response = await http.post(url, body: body);

//   Map finalResponse = jsonDecode(response.body);

//   return finalResponse;

// }

Future<Map> likePost(int bId) async {
  SharedPreferences prefs = await _prefs;

  int? id = prefs.getInt("id");
  Uri url = Uri.parse("$uriBase/blogs/likePost/");

  var body = jsonEncode({"blogId": bId, "id": id});

  var response = await http.post(url, body: body);

  Map finalResponse = jsonDecode(response.body);

  return finalResponse;
}
