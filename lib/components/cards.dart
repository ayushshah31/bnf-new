// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Cards extends StatelessWidget {
  String name;
  String desc;
  String exp;
  String link;
  Cards(
      {required this.name,
      required this.desc,
      required this.exp,
      required this.link});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          name,
          style: TextStyle(fontSize: 15),
        ),
        Text(
          desc,
          style: TextStyle(fontSize: 12),
        ),
        Text(
          exp,
          style: TextStyle(fontSize: 12),
        ),
        TextButton(
            onPressed: () async {
              var url = link;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'couldnt launch $url';
              }
            },
            child: Text(
              link,
              style: TextStyle(fontSize: 12),
            ))
      ]),
    );
  }
}
