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
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                exp,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () async {
                    var url = link;
                    // if (await canLaunch(url)) {
                      await launch(url);
                    // } else {
                    //   throw 'couldnt launch $url';
                    // }
                  },
                  child: Text(
                    'For More Details...',
                    textWidthBasis: TextWidthBasis.parent,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ))
            ]),
      ),
    );
  }
}
