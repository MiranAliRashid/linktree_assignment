import 'package:biolinktree_assignment/screens/constants/config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Bio extends StatefulWidget {
  Bio({Key? key}) : super(key: key);

  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Bio> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 120,
                    // height: 120,
                    child: Image.network(user["profileImage"]!),
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
                    child: Text(user["name"] ?? "no user"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(user["title"] ?? "no title"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(user["location"] ?? "no location"),
                  ),
                ],
              ),
              const Divider(),
              Column(
                children: [
                  Container(
                    child: Text(
                      user["bio"] ?? "no bio",
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
                height: 240,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: links.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return Text(links.keys.elementAt(index));
                      return coustomList(links.values.elementAt(index),
                          links.keys.elementAt(index));
                    },
                  ),
                ),
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
                        launch(phone["phone"]!);
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
