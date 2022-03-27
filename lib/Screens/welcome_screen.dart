import 'package:animated_text_kit/animated_text_kit.dart';
import 'registration_screen.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController myController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    myController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,);
    myController.forward();
    animation = ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(myController);
    myController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      child: Image.asset('images/logo.png'),
                      height: 60,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      width: 190.0,
                      child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'OfferIt',
                              textStyle: const TextStyle(
                              // fontFamily: 'OS',
                                fontSize: 45.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                          totalRepeatCount: 3,
                          pause: const Duration(seconds: 2),
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  // color: Colors.black54,
                  // text: 'Log In',
                  style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(left: 9, right: 9)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black87),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ))),
                     child: Text('Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "OS",
                                  fontSize: 18,
                                ))  ,         
                  onPressed: ()=>Navigator.pushNamed(context, LoginScreen.id)),
            ),
           ElevatedButton(
                // color: Colors.black54,
                // text: 'Log In',
                style: ButtonStyle(
                              // padding: MaterialStateProperty.all(
                              //     EdgeInsets.only(left: 9, right: 9)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black87),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ))),
                   child: Text('Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "OS",
                                fontSize: 18,
                              ))  ,         
                 onPressed: ()=>Navigator.pushNamed(context, RegistrationScreen.id)),
            
         
          ],
        ),
      ),
    );
  }
}