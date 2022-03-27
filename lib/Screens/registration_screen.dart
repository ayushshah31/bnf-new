import 'package:firebase_database/firebase_database.dart';
import 'package:bnf/Screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import 'imageCapture.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>{

  final _auth = FirebaseAuth.instance;
  String email='';
  String password = '';
  bool showSpinner = false;
  String name="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios,color: Colors.black54,)),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email',
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Name'),
                ),
                TextField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                    color: Colors.blueAccent,
                    text: 'Register',
                    onPressed: () async{
                      print(email);
                      print(password);
                      try {
                        setState(() {
                          showSpinner=true;
                        });
                        final newUser = await _auth
                            .createUserWithEmailAndPassword(
                            email: email.trim(), password: password.trim());
                        if(newUser != null)
                          {
                            setState(() {
                              showSpinner=false;
                            });
                            User? mFirebaseUser = FirebaseAuth.instance.currentUser;
                            final databaseReference = FirebaseDatabase.instance.reference();
                            DatabaseReference mUserPointsRef = databaseReference.child('User');
                            mUserPointsRef.set(mFirebaseUser?.uid);
                            mUserPointsRef.child(mFirebaseUser!.uid).child("Name").set(name);
                            mUserPointsRef.child(mFirebaseUser.uid).child("Email").set(email);
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Home(name: name)));
                          }
                      }
                      catch(e)
                      {
                        throw e;
                      }
                }),
              ],
            ),
          ),
      ),
    );
  }
}
