// ignore_for_file: prefer_const_constructors

import 'package:bnf/Model/offerDataModel.dart';
import 'package:bnf/Screens/Profile.dart';
import 'package:bnf/Screens/imageCapture.dart';
import 'package:bnf/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bnf/constants.dart';
import 'package:bnf/dataFetch/FirebaseFetch.dart';

import 'offerDisplay.dart';

enum SingingCharacter { debit, credit }

class Home extends StatefulWidget {
  String name;

  Home({required this.name});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cc = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex=0;
  late List<OfferDataModel> data;

  static List<Widget> _pages = [
    Profile(),
    ImageCapture(),
    OffersDisplay(),
  ];

  void onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            ElevatedButton(
              child: Text("Logout"),
              onPressed: () {
                _auth.signOut();
                print("Signout");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
            ),
          ],
        ),
        body: _pages.elementAt(_selectedIndex),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.card_membership),
              label: 'Add Cards',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Offers',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: onItemTapped,
        ),
        );
  }

}



