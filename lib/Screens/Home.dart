// ignore_for_file: prefer_const_constructors

import 'package:bnf/Model/offerDataModel.dart';
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
  String dropValue = "ICICI";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SingingCharacter? _character = SingingCharacter.debit;
  int _selectedIndex=0;
  var cardNo = 0;
  late List<OfferDataModel> data;

  static List<Widget> _pages = <Widget>[];

  void onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      profile(),
      ImageCapture(),
      OffersDisplay(),
    ];
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
        body: _pages.elementAt(_selectedIndex));
  }
  Widget profile(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Choose type of card:",
            style: TextStyle(fontSize: 15),
          ),
          ListTile(
            title: const Text('Debit'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.debit,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Credit'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.credit,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          Row(
            children: [
              Text(
                "Choose bank:",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                width: 20,
              ),
              DropdownButton<String>(
                value: dropValue,
                items: <String>['ICICI', 'Axis', 'HDFC', 'PNB']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    dropValue = val!;
                  });
                },
              ),
            ],
          ),
          Text(
            cardNo.toString(),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 30,),
          TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                cardNo = int.parse(value);
              });
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Enter Card N0.',
            ),
          ),
        ],
      ),
    );
  }
}



