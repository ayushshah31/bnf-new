import 'package:bnf/Screens/Home.dart';
import 'package:bnf/Screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:bnf/Screens/welcome_screen.dart';
import 'package:bnf/Screens/login_screen.dart';
import 'package:bnf/Screens/registration_screen.dart';
// import 'package:fnb/Screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  //necessary for firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const OfferAssistant());
}

class OfferAssistant extends StatelessWidget {
  const OfferAssistant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id: (context)=>LoginScreen(),
        WelcomeScreen.id: (context)=>const WelcomeScreen(),
        RegistrationScreen.id: (context)=>RegistrationScreen(),
        // ChatScreen.id: (context)=>ChatScreen(),
      },
      home: Wrapper(),
    );
  }
}