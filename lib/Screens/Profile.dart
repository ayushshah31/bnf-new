import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  User? _currentUser = FirebaseAuth.instance.currentUser;
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async{
    DatabaseReference mUserPointsRef = databaseReference.child('User');
    DataSnapshot sp =  await mUserPointsRef.child(_currentUser!.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.person,size: 10,),
          ],
        ),
      ),
    );
  }
}
