import 'package:biolinktree_assignment/data_models/userModel.dart';
import 'package:biolinktree_assignment/screens/constants/config.dart';
import 'package:biolinktree_assignment/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Bio extends StatefulWidget {
  Bio({Key? key}) : super(key: key);

  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Bio> {
  @override
  Widget build(BuildContext context) {
    var _authProvider = Provider.of<AuthService>(context);
    var mi =
        FirebaseFirestore.instance.collection('users_linktree').snapshots();
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: StreamBuilder<QuerySnapshot>(
            stream: mi,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('error0');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Text('empty1');
              } else if (snapshot.connectionState == ConnectionState.done) {
                return LinearProgressIndicator();
              }

              List<DocumentSnapshot> _docs = snapshot.data!.docs;

              List<UserModel> _users = _docs
                  .map((e) =>
                      UserModel.fromMap(e.data() as Map<String, dynamic>))
                  .toList();
              return Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 120,
                          // height: 120,
                          child: Image.network(
                            _users[0].profileImg.toString(),
                            width: 150,
                            height: 100,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 120,
                          color: Colors.grey[100]!.withOpacity(0.4),
                          child: Text("looking for a job"),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(_users[0].userName ?? "no user"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(user["title"] ?? "no title"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(_users[0].location ?? "no location"),
                        ),
                      ],
                    ),
                    const Divider(),
                    Column(
                      children: [
                        Container(
                          child: Text(
                            _users[0].bio ?? "no bio",
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 280,
                      child: Expanded(
                          child: ListView(
                        children: [
                          coustomList(_users[0].linkGitHub!, "GitHub"),
                          coustomList(
                              _users[0].linkStakOverFlow!, "StackOverFlow"),
                          coustomList(_users[0].linkLinkedIn!, "LinkedIn"),
                        ],
                      )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              launch(_users[0].phone.toString());
                            },
                            icon: Icon(Icons.phone),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.mobile_friendly),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.phone),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  coustomList(String url, String val) {
    return TextButton(
      onPressed: () async {
        await launch(url);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        height: 80,
        color: Colors.blueGrey[50],
        child: Text(
          val,
        ),
      ),
    );
  }
}
