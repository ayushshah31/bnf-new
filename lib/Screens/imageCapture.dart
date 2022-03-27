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
  late File imagePath;
  void captureImage() async {
    XFile? image =
        await _capture.pickImage(source: ImageSource.camera, imageQuality: 100);
    setState(() {
      path = image?.path.toString();
      imagePath = File(image!.path);
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("Capture Image",style: TextStyle(fontSize: 20),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade700),
                  ),
                  onPressed: () {
                    captureImage();
                    setState(() {
                      show_image = false;
                      displayText = "";
                    });
                  },
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Converted Text: $displayText'),
                          show_image
                              ? Image.file(
                                  imagePath,
                                  fit: BoxFit.fill,
                                )
                              : Text("Click Picture for OCR"),
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
