// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:bnf/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ImageCapture extends StatefulWidget {
  const ImageCapture({Key? key}) : super(key: key);

  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  final ImagePicker _capture = ImagePicker();
  bool show_image = false;
  String? path = "";
  String finalText = "";
  String displayText = "";
  List<String> textList = [];
  List<File> imagePathList = [];
  late File imagePath;
  void captureImage() async {
    XFile? image =
        await _capture.pickImage(source: ImageSource.camera, imageQuality: 100);
    setState(() {
      path = image?.path.toString();
      imagePathList.add(File(image!.path));
    });
    textDetection();
  }

  void textDetection() async {
    final image = InputImage.fromFilePath(path!);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText _recognizedText =
        await textDetector.processImage(image);

    for (TextBlock block in _recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          finalText = finalText + " " + element.text;
        }
        finalText = finalText + "\n";
      }
    }
    textList.add(finalText);
    setState(() {
      show_image = true;
      displayText = finalText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 
                Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.center,
                  child: IconButton(
                  icon: Icon(Icons.camera_alt_rounded,
            color: Colors.white,
                              size: 50,),
                 
                  onPressed: () {
                    captureImage();
                  },
                ),),
                SizedBox(height: 30,),
                Card(
                  margin: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          show_image
                              ? Container(
                            height: 490,
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemCount: textList.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("\nImage ${i+1} Converted Text:-",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    Text(DateTime.now().toString(),style: TextStyle(fontSize: 18),),
                                    SizedBox(height: 5,),
                                    Text(textList[i]),
                                    Text("Captured Image:",style: TextStyle(fontSize: 20),),
                                    Image.file(
                                    imagePathList[i],
                                    fit: BoxFit.fill,
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
                          )
                              : Text("Coupon Text", style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "OS",
                                  fontSize: 18,
                                )),
                        ],
                      ),
                    ),
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
