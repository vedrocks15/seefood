import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:seefood/screens/constants.dart';
import 'package:seefood/image_loader.dart';
import 'dart:io';
import 'package:seefood/model_main.dart';
import 'dart:math';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _model_Load = false;
  //initial settings
  String textToDisplay = "Let's Get Started";
  AlignmentGeometry adjustPosition = Alignment.topCenter;
  int st = 1;

  //Text for main screen
  Widget renderContainer(int x) {
    if (x == 1)
      return Column(
        children: <Widget>[
          Text(
            textToDisplay,
            style: whiteText.copyWith(
              fontSize: 40.0,
            ),
          ),
        ],
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          MaterialButton(
            onPressed: () async {
              File i = await loadImage();
              print(i.path);
              Uint8List imgProcess = await processImage(i);
              if (imgProcess != null) print("Processed");
              runModel(imgProcess);
            },
            color: Colors.red,
            shape: CircleBorder(
              side: BorderSide(
                width: 5,
                color: Colors.black,
              ),
            ),
            child: Text(
              " ",
              style: TextStyle(fontSize: 60),
            ),
          ),
          Text(
            textToDisplay,
            style: whiteText.copyWith(
              fontSize: 40.0,
            ),
          ),
        ],
      );
  }

  //Positioning and alternation on Tap
  void handleAnimation() {
    if (adjustPosition == Alignment.topCenter) {
      setState(() {
        adjustPosition = Alignment.bottomCenter;
        textToDisplay = "Touch to SEEFOOD";
        st = 2;
      });
    } else {
      setState(() {
        adjustPosition = Alignment.topCenter;
        textToDisplay = "Let's Get Started";
        st = 1;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model_Load = true;
    loadModel().then((value) {
      print("Model loaded $value");
      setState(() {
        _model_Load = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    modelFree();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 90.0,
            decoration: BoxDecoration(
              color: Color(0xFFab150a),
            ),
            child: Text("SEEFOOD", style: whiteText),
          ),
          Container(
            alignment: Alignment.center,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.white10,
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Text(
              '"The Shazam for Food"',
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: handleAnimation,
              child: Container(
                padding: EdgeInsets.only(
                  top: 70.0,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/image3.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: renderContainer(st),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
