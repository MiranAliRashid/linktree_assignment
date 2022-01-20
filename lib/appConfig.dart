import 'package:biolinktree_assignment/screens/login_screen/login_screen_view.dart';
import 'package:biolinktree_assignment/screens/registeration_screen/register_screen.dart';
import 'package:flutter/material.dart';

class AppConfig extends StatefulWidget {
  AppConfig({Key? key}) : super(key: key);

  @override
  _AppConfigState createState() => _AppConfigState();
}

class _AppConfigState extends State<AppConfig> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
