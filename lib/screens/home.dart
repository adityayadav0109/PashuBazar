import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pashubazar/models/user.dart';
import 'package:pashubazar/screens/buy.dart';
import 'package:pashubazar/screens/sell.dart';
import 'package:pashubazar/screens/profile.dart';
import 'package:pashubazar/screens/settings.dart';
import 'package:pashubazar/screens/sign_in.dart';

class HomePage extends StatefulWidget {
  final preferences;

  final currentUser;
  final String email;

  const HomePage({Key? key, required this.preferences, required this.currentUser, required this.email}) : super(key: key);

  //this is the code which is added to new branch


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences _preferences;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _currentUser = User(email: widget.email, username: '', password: '');
  }

  Future<void> _loadPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pashubazar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'Hi,',
            //   style: TextStyle(fontSize: 24),
            // ),
            // Text(
            //   '${_currentUser.username}',
            //   style: const TextStyle(fontSize: 18),
            // ),
            // const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SellPage()),
                );
              },
              child: const Text('Sell'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BuyPage()),
                );
              },
              child: const Text('Buy'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Hello Aditya!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(preferences: _preferences)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage(preferences: _preferences)),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                // Remove the user email from preferences
                await _preferences.remove('email');

                // Navigate back to the SignInPage and replace the current route
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage(
                    onUserSaved: (user) {
                      // do something when the user is saved
                    },
                  ),),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
