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
  int cardCount=0;
  bool creditBool = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(height: 100,),
              Expanded(
                  child: ElevatedButton(
                 style: ButtonStyle(
                              
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black87),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ))),
                     child: Text('Add Card',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "OS",
                                  fontSize: 18,
                                ))  ,    
                onPressed: ()=>setState(()=>showAddCard=true),
              )),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: ElevatedButton(
                 style: ButtonStyle(
                              
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black87),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ))),
                     child: Text('View Cards',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "OS",
                                  fontSize: 18,
                                ))  ,    
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));},
              )),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Text(
                "Bank:",
                style: TextStyle(fontSize: 20,
                fontFamily: 'OS',
                fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20,
              ),
              DropdownButton<String>(
                value: dropValue,
                items: <String>['ICICI', 'AXIS', 'BOB'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "OS",
                                            fontSize: 17,
                                          )
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
          Container(
            alignment: Alignment.centerLeft,
            child:Text(
                "Type of Card:",
                style: TextStyle(fontSize: 20,
                fontFamily: 'OS',
                fontWeight: FontWeight.bold),
              ),),
          ListTile(
            title: const Text('Debit',style: TextStyle(
              fontSize: 20,
                fontFamily: 'OS',
            ),),
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
            title: const Text('Credit',style: TextStyle(
              fontSize: 20,
                fontFamily: 'OS',)),
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
          SizedBox(height: 
          9,),
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
                .child(mFirebaseUser.hashCode.toString()).child("Num").set(cardNo);
            mUserPointsRef
                .child(mFirebaseUser.uid)
                .child("Card").child(mFirebaseUser.hashCode.toString()).child("type").set(creditBool?"Credit":"Debit");
            mUserPointsRef
                .child(mFirebaseUser.uid)
                .child("Card").child(mFirebaseUser.hashCode.toString()).child("bank").set(dropValue);
            print("Added");
          }, 
           style: ButtonStyle(
                              
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black87),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ))),child: Text('Add',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "OS",
                                  fontSize: 15,
                                ))):Text(""),
        ],
      ),
    );
  }
}
