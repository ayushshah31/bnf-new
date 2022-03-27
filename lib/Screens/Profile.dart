import 'package:bnf/components/cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _currentUser = FirebaseAuth.instance.currentUser;
  late DatabaseReference mUserPointsRef;
  final databaseReference = FirebaseDatabase.instance.reference();
  String name = "";
  String email = "";
  List card = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mUserPointsRef = databaseReference.child('User');
  }

  List<Widget> cardDetails = <Widget>[];

  void getData(AsyncSnapshot<DataSnapshot> snapshot) async {
    String _bankName, _type;
    int _no;

    var card = snapshot.data!.value['Card'];
    print("card: "+card.toString());
    for (var i in card.values) {
      _bankName = i['bank'];
      _no = i['Num'];
      _type = i['type'];
      cardDetails.add(Card(
        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 30, 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bank: " + _bankName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Number: " + _no.toString(),
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Type: " + _type,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
              ]),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DataSnapshot>(
          future: mUserPointsRef.child(_currentUser!.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              getData(snapshot);
              print(snapshot.data!.value.toString());
              return Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                              child: Material(
                            color: Colors.transparent,
                            child: Ink.image(
                              image: AssetImage(
                                  'images/User_font_awesome.svg.png'),
                              fit: BoxFit.cover,
                              width: 128,
                              height: 128,
                              child: InkWell(onTap: () {}),
                            ),
                          )),
                          // Icon(Icons.person,size: 100,),
                          SizedBox(height: 10,),
                          Text(snapshot.data!.value['Name'].toString(),style: TextStyle(color: Colors.black,
                                  fontFamily: "OS",
                                  fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),      
                          Text(
                            
                                snapshot.data!.value['Email'].toString(),
                            style: TextStyle(color: Colors.black,
                                  fontFamily: "OS",
                                fontSize: 16, ),
                          ),
                           SizedBox(height: 5,),   
                          Text(
                            "Cards Stored:",
                            style: TextStyle(fontSize: 20,color: Colors.black,
                                  fontFamily: "OS",),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: cardDetails,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
