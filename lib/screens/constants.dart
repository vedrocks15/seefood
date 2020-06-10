import 'package:flutter/material.dart';

const TextStyle whiteText = TextStyle(
  inherit: true,
  fontSize: 70.0,
  color: Colors.white,
  fontWeight: FontWeight.w900,
  shadows: [
    Shadow(
        // bottomLeft
        blurRadius: 10.0,
        offset: Offset(-5.0, -5.0),
        color: Colors.black),
    Shadow(
        // bottomRight
        blurRadius: 10.0,
        offset: Offset(5.0, -5.0),
        color: Colors.black),
    Shadow(
        // topRight
        blurRadius: 10.0,
        offset: Offset(5.0, 5.0),
        color: Colors.black),
    Shadow(
        // topLeft
        blurRadius: 10.0,
        offset: Offset(-5.0, 5.0),
        color: Colors.black),
  ],
);
