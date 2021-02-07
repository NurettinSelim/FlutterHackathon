import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class ImageToText {
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  Future<String> convert(imagePath) async {
    var imageFile = File(imagePath);
    final visionImage = FirebaseVisionImage.fromFile(imageFile);
    final visionText = await textRecognizer.processImage(visionImage);
    var text = visionText.text;
    return text;
  }
}
