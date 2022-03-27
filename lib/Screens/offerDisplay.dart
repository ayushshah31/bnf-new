import 'package:bnf/Model/offerDataModel.dart';
import 'package:bnf/components/cards.dart';
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
              child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Offers for AXIS BANK",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 170,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Row(
                            children: [
                              Cards(desc: data[i].details,exp: data[i].dueDate,link: data[i].url,name: data[i].brandName,),
                            ],
                          );
                          },
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
