import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bnf/Model/offerDataModel.dart';

class FirebaseFetch{
  final databaseReference = FirebaseDatabase.instance.reference();
  List<OfferDataModel> data = [];
  Future getOfferDetails(String bankName) async {
    print("Entered getUser");
    User? mFirebaseUser = FirebaseAuth.instance.currentUser;
    var result;
    try {
      result = (await databaseReference.child("Bank").child("Axis").once()).value;
      final resultData = jsonDecode(result);
      print(resultData);
    }catch(e){
      print(e);
    }
    print("result: "+result.toString());
    for(var search=0;search<5;search++){
      OfferDataModel user = new OfferDataModel();
      user.brandName = result[search]["Bank Name"];
      user.cardType = result[search]["card Type"];
      user.details = result[search]["Details"];
      user.dueDate = result[search]["Due Date"];
      user.url = result[search]["Link"];
      data.add(user);
    }
    print(data.toString());
    return data;
    // if(result==null){
    //   return new UserModel();
    // }
    // else{
    //   UserModel user = new UserModel();
    //   user.phone = result['phone'];
    //   user.points = result['points'];
    //   user.sap = result['SAP'];
    //   user.name = result['name'];
    //   user.email = result['email'];
    //   return user;
    // }
  }

  Future getEvents() async {
    var result = (await databaseReference.child("Bank").child("Axis").once()).value;
    print(result.runtimeType);
    List<OfferDataModel> events = [];
    for (LinkedHashMap child in result) {
      OfferDataModel user = new OfferDataModel();
      user.brandName = child["Brand Name"];
      user.cardType = child["Card Type"];
      user.details = child["Detail"];
      user.dueDate = child["Due Date"];
      user.url = child["Link"];
      events.add(user);
      print(user.brandName);
    }
    return events;
  }

  Future getTp() async{
    User? mFirebaseUser = FirebaseAuth.instance.currentUser;
    var result;
    await databaseReference.child("Tp").once().then((value) => print(value));
    print(result);
  }

}