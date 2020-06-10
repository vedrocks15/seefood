import 'dart:typed_data';
import 'dart:math';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';

Future<String> loadModel() async {
  String res = await Tflite.loadModel(
    model: "assets/converted_model.tflite",
    labels: "assets/labels.txt",
    numThreads: 2,
    isAsset: true,
  );
  return res;
}

void runModel(Uint8List resizedImage) async {
  var recognitions = await Tflite.runModelOnBinary(
    binary: resizedImage,
    numResults: 2,
    threshold: 0.5,
  );
  print(recognitions);
}

void modelFree() {
  Tflite.close();
}
