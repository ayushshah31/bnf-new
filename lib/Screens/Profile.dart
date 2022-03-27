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
  String name="";
  String email="";
  List card = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mUserPointsRef = databaseReference.child('User');
  }

  List<Widget> cardDetails = <Widget>[];

  void getData(AsyncSnapshot<DataSnapshot> snapshot) async{
    String _bankName,_type;
    int _no;

    var card = snapshot.data!.value['Card'];

    for(var i=0 ; i<card.length ; i++){
      _bankName = card[i]['bank'];
      _no = card[i]['Num'];
      _type = card[i]['type'];
      cardDetails.add(Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 30, 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "Bank: "+_bankName,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Number: "+_no.toString(),
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Type: " + _type,
                  style: TextStyle(fontSize: 12),
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
        builder: (context,snapshot){
          if(snapshot.hasData){
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
                        Icon(Icons.person,size: 100,),
                        SizedBox(height: 10,),
                        Text("Name: "+snapshot.data!.value['Name'].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text("Email: "+snapshot.data!.value['Email'].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        Text("Card Detail(s):",style: TextStyle(fontSize: 20),),
                        SizedBox(height: 5,),
                        Column(
                          children: cardDetails,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
        ),
    );
  }
}
