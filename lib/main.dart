import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';
import 'screens/home.dart';
import 'screens/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences _preferences;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _initializeCurrentUser();
  }

  Future<void> _initializeCurrentUser() async {
    _preferences = await SharedPreferences.getInstance();
    final username = _preferences.getString('username') ?? '';
    final email = _preferences.getString('email') ?? '';
    final password = _preferences.getString('password') ?? '';
    setState(() {
      _currentUser = User(username: username, email: email, password: password);
    });
  }

  void _updateUser(User user) {
    setState(() {
      _currentUser = user;
    });
    _preferences.setString('username', user.username);
    _preferences.setString('email', user.email);
    _preferences.setString('password', user.password);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/sign-in',
      routes: {
        '/': (context) => HomePage(
          preferences: _preferences,
          currentUser: _currentUser,
          email: _currentUser.email,
        ),
        '/sign-in': (context) => SignInPage(onUserSaved: _updateUser),
      },
    );
  }
}
