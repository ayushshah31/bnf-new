// ignore_for_file: prefer_const_constructors

import 'package:bnf/Model/offerDataModel.dart';
import 'package:bnf/components/cards.dart';
import 'package:bnf/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:bnf/dataFetch/FirebaseFetch.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:url_launcher/url_launcher.dart';

class OffersDisplay extends StatefulWidget {
  const OffersDisplay({Key? key}) : super(key: key);

  @override
  State<OffersDisplay> createState() => _OffersDisplayState();
}

class _OffersDisplayState extends State<OffersDisplay> {
  bool isLoading = true;
  List<OfferDataModel> data = <OfferDataModel>[];
  String message = "Please add a card first to View Offers";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fns();
  }

  void fns() async {
    try{
      User? mFirebaseUser = FirebaseAuth.instance.currentUser;
      final databaseReference =
      FirebaseDatabase.instance.reference();
      DatabaseReference mUserPointsRef = databaseReference.child('User');
      String bankName = mUserPointsRef
          .child(mFirebaseUser!.uid)
          .child("Card")
          .child("0").child("bank").get().toString();
      FirebaseFetch dataFetch = FirebaseFetch();
      data = await dataFetch.getEvents(bankName);
      setState(() {
        isLoading = false;
      });
      data.forEach((element) {
        // print(element.brandName);
      });
    } catch(e){
      setState(() {
        message = e.toString();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    isLoading?message:"Offers for AXIS BANK",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Row(
                        children: [
                          Container(
                            width: 350,
                            
                            child: Cards(
                              desc: data[i].details,
                              exp: data[i].dueDate,
                              link: data[i].url,
                              name: data[i].brandName,
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
