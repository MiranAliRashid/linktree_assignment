import 'package:biolinktree_assignment/screens/create_profile/CreateProfileScreen.dart';
import 'package:biolinktree_assignment/screens/landing_screen/bio.dart';
import 'package:biolinktree_assignment/screens/login_screen/login_screen_view.dart';
import 'package:biolinktree_assignment/screens/registeration_screen/register_screen.dart';
import 'package:biolinktree_assignment/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthHandler extends StatelessWidget {
  AuthHandler({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthService>(context, listen: true)
        .theUser; //firebase auth user

    //checking with the firebase auth service for user
    if (user != null) {
      return Scaffold(
        backgroundColor: Colors.amber,
        body: FutureBuilder(
          future: Provider.of<AuthService>(context, listen: false)
              .fetchUserInfo(user.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.data == false) {
              return CreateProfileScreen();
            } else if (snapshot.data == true) {
              return Bio();
            } else {
              return LoginScreen();
            }
          },
        ),
      );
    } else {
      return LoginScreen(); //main screen for non authenticates users
    }
  }
}
