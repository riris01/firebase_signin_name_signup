import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_practice/login_page.dart';
import 'package:flutter_login_practice/my_home_page.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  bool _isLoggedIn = false; //state variable 추가

  @override
  void initState() {
    super.initState();
    _isLoggedIn = FirebaseAuth.instance.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['a', 'b', 'c', 'd', 'e'];
    final List<int> colorCodes = <int>[600, 500, 400, 300, 200];

    return Scaffold(
      appBar: AppBar(
        title: Text('Potato Market'),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Row(
              children: [
                if (_isLoggedIn)
                  Text(FirebaseAuth.instance.currentUser!.email.toString())
                else
                  Text('Please login'), // 조건문 추가
                IconButton(
                    onPressed: () => _logout(),
                    icon: Icon(Icons.exit_to_app_sharp)),
              ],
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            width: 400,
            color: Colors.amber[colorCodes[index]],
            child: Center(
              child: Text('In order ${entries[index]}'),
            ),
          );
        },
        separatorBuilder: (BuildContext context, index) => const Divider(),
      ),
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      setState(() {
        _isLoggedIn = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have signed out')),
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sign out failed'),
      ));
    }
  }
}
