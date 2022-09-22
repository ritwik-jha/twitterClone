import 'package:ctwitter/apiFunctions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String author = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserDetails().then((value) {
      if (value['message'] == 'success') {
        setState(() {
          author = value['data']['username'];
          email = value['data']['email'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: author == "" ? Text('Loading..') : Text(author),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                // child: Image.network(
                //   'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                //   fit: BoxFit.cover,
                //   width: 90,
                //   height: 90,
                // ),
                child: Container(
                  height: 90,
                  width: 90,
                  color: Colors.grey,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //     image: NetworkImage(
              //         'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(
              Icons.document_scanner,
              color: Colors.white,
            ),
            title: const Text('Compose', style: TextStyle(color: Colors.white)),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(
              Icons.tag,
              color: Colors.white,
            ),
            title: const Text('Search', style: TextStyle(color: Colors.white)),
            onTap: () => null,
          ),
          // const ListTile(
          //   leading: Icon(
          //     Icons.notifications,
          //     color: Colors.white,
          //   ),
          //   title: Text('Request', style: TextStyle(color: Colors.white)),
          // ),
          Divider(),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Colors.white,
            ),
            title:
                const Text('Policies', style: TextStyle(color: Colors.white)),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: const Text('Exit', style: TextStyle(color: Colors.white)),
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
