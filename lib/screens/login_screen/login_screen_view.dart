import 'package:biolinktree_assignment/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  late String theLoggedInUser;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            // Text('Welcome $email'),
            Form(
                child: Column(
              children: [
                // Text('the logged in user: $theLoggedInUser'),

                //user name
                TextFormField(
                  controller: _userNameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: generalInputDecoration(
                      labelText: 'User Name', hintText: 'email@something.com'),
                ),
                //passsword

                SizedBox(height: 15),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: generalInputDecoration(labelText: 'Password'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      email = _userNameController.value.text;
                      password = _passwordController.value.text;
                    });
                    email = email.trim(); //remove spaces
                    email = email.toLowerCase(); //convert to lowercase

                    await Provider.of<AuthService>(context, listen: false)
                        .loginWithEmailAndPassword(email, password)
                        .then((value, {Function? onError}) {
                      if (onError == false) {
                        print("there is error null or empty");
                      } else {
                        setState(() {
                          theLoggedInUser = value!.user!.uid;
                        });
                        Navigator.pop(context);
                      }
                    });
                  },
                  icon: Icon(
                    Icons.login,
                  ),
                  label: Text(
                    'Login',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("you don't have an account "),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                        child: Text("Register here!"))
                  ],
                ),
                //error
                Provider.of<AuthService>(context).theError == null
                    ? Container()
                    : Container(
                        child: Text(
                          Provider.of<AuthService>(context).theError!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  InputDecoration generalInputDecoration(
      {required String labelText, String? hintText}) {
    return InputDecoration(
      label: Text(labelText),
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
