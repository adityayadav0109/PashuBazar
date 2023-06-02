import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pashubazar/models/user.dart';
import 'package:pashubazar/screens/buy.dart';
import 'package:pashubazar/screens/sell.dart';
import 'package:pashubazar/screens/profile.dart';
import 'package:pashubazar/screens/settings.dart';
import 'package:pashubazar/screens/sign_in.dart';
import 'package:pashubazar/screens/chats.dart';
import 'package:pashubazar/screens/deals.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomePage extends StatefulWidget {
  final SharedPreferences preferences;
  final User currentUser;
  final String email;

  const HomePage({Key? key, required this.preferences, required this.currentUser, required this.email}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences _preferences;
  late User _currentUser;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeWidget(),
    ChatsPage(),
    DealsPage(),
  ];

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
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Deals',
          ),
        ],
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
                'Hello User!',
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

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // const Text(
          //   'Home Page',
          //   style: TextStyle(fontSize: 24),
          // ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SellPage()),
              );
            },
            child: const Text('Sell'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BuyPage()),
              );
            },
            child: const Text('Buy'),
          ),
        ],
      ),
    );
  }
}
