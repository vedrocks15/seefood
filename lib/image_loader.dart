import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:image/image.dart' as img;

//returns a promise that image will be loaded
Future loadImage() async {
  var i = await ImagePicker.pickImage(source: ImageSource.gallery);
  if (i == null) return;
  return i;
}

// function also handles the normalization aspect
Uint8List imageToByteListFloat32(
    img.Image image, int inputSize, double mean, double std) {
  var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  var buffer = Float32List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image.getPixel(j, i);
      buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
      buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
      buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
    }
  }
  return convertedBytes.buffer.asUint8List();
}

Uint8List imageToByteListUint8(img.Image image, int inputSize) {
  var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
  var buffer = Uint8List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image.getPixel(j, i);
      buffer[pixelIndex++] = img.getRed(pixel);
      buffer[pixelIndex++] = img.getGreen(pixel);
      buffer[pixelIndex++] = img.getBlue(pixel);
    }
  }
  return convertedBytes.buffer.asUint8List();
}

Future<Uint8List> processImage(File image) async {
  //receiving the image file from image picker
  var imageBytes = (await rootBundle.load(image.path))
      .buffer; //byte buffer conversion (built in)
  img.Image oriImage =
      img.decodeJpg(imageBytes.asUint8List()); //decode jpg is built in
  img.Image resizedImage = img.copyResize(oriImage,
      height: 224, width: 224); //resize image to appropriate dimensions
  return imageToByteListFloat32(resizedImage, 224, 0, 255);
}
