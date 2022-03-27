import 'package:bnf/Screens/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:bnf/constants.dart';

import 'Home.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  SingingCharacter? _character = SingingCharacter.debit;
  String dropValue = "ICICI";
  var cardNo = 0;
  bool showAddCard = false;
  static int cardCount=0;
  bool creditBool = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                child: Text("Add"),
                onPressed: ()=>setState(()=>showAddCard=true),
              )),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: ElevatedButton(
                child: Text("View"),
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));},
              )),
            ],
          ),
          SizedBox(height: 15,),

          SizedBox(
            height: 15,
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
                items: <String>['ICICI', 'AXIS', 'BoB'].map((String value) {
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
          SizedBox(
            height: 30,
          ),
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
                  creditBool = false;
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
                  creditBool = true;
                });
              },
            ),
          ),
          showAddCard?TextFormField(
            validator: (value){
              if(value!.length < 16 || value.length>16 ){
                return 'Incorrect Details Entered';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) {
              setState(() {
                cardNo = int.parse(value);
              });
            },
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Enter Card No.',
            ),
          ):Text(""),
          showAddCard?ElevatedButton(onPressed: () {
            User? mFirebaseUser = FirebaseAuth.instance.currentUser;
            final databaseReference =
            FirebaseDatabase.instance.reference();
            DatabaseReference mUserPointsRef = databaseReference.child('User');
            mUserPointsRef
                .child(mFirebaseUser!.uid)
                .child("Card")
                .child(cardCount.toString()).child("Num").set(cardNo);
            mUserPointsRef
                .child(mFirebaseUser.uid)
                .child("Card").child(cardCount.toString()).child("type").set(creditBool?"Credit":"Debit");
            mUserPointsRef
                .child(mFirebaseUser.uid)
                .child("Card").child(cardCount.toString()).child("bank").set(dropValue);
            cardCount++;
            print("Added");
          }, child: Text("Submit")):Text(""),
        ],
      ),
    );
  }
}
