import 'package:bnf/Model/offerDataModel.dart';
import 'package:flutter/material.dart';
import 'package:bnf/dataFetch/FirebaseFetch.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class OffersDisplay extends StatefulWidget {
  const OffersDisplay({Key? key}) : super(key: key);

  @override
  State<OffersDisplay> createState() => _OffersDisplayState();
}

class _OffersDisplayState extends State<OffersDisplay> {

  bool isLoading = true;
  List<OfferDataModel> data = <OfferDataModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fns();
  }

  void fns() async{
    FirebaseFetch dataFetch = new FirebaseFetch();
    data = await dataFetch.getEvents();
    setState(() {
      isLoading = false;
    });
    data.forEach((element) {
      print(element.brandName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Center(
              child:TextButton(
                child: Text("press"),
                onPressed: () {},
              )
          ),
        ),
      ),
    );
  }
}
