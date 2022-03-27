import 'package:flutter/material.dart';
import 'package:bnf/constants.dart';

import 'Home.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SingingCharacter? _character = SingingCharacter.debit;
  String dropValue = "ICICI";
  var cardNo = 0;

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
                onPressed: () {},
              )),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: ElevatedButton(
                child: Text("View"),
                onPressed: () {},
              )),
            ],
          ),
          SizedBox(height: 15,),
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
          Text(
            cardNo.toString(),
            style: TextStyle(
              fontSize: 20,
            ),
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
          ElevatedButton(onPressed: () {}, child: Text("Submit"))
        ],
      ),
    );
  }
}
