// ignore_for_file: prefer_const_constructors

import 'package:bnf/Model/offerDataModel.dart';
import 'package:bnf/Screens/Profile.dart';
import 'package:bnf/Screens/addCard.dart';
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
  int _selectedIndex = 0;
  late List<OfferDataModel> data;

  static List<Widget> _pages = [
    AddCard(),
    ImageCapture(),
    OffersDisplay(),
    Profile(),
  ];

  List<String> title = [
    "Add Cards",
    "Camera",
    "Offers",
    "Profile"
  ];

  void onItemTapped(int index) {
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title[_selectedIndex], style: TextStyle(fontFamily: 'OS'),),
        backgroundColor: blackColor,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app,
            color: Colors.white,
                              size: 20,),
            
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
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_membership,
              color: Colors.black,
            ),
            label: 'Add Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera, color: Colors.black),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer, color: Colors.black),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
