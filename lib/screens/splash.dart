import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/screens/mainScreen.dart';
import 'package:news_app/style/theme.dart' as Style;

class SplashScreenn extends StatefulWidget {
  const SplashScreenn({Key? key}) : super(key: key);

  @override
  State<SplashScreenn> createState() => _SplashScreennState();
}

class _SplashScreennState extends State<SplashScreenn> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:58),
        ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MainScreen())));


  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Container(
            height: 200,
            width: 150,
            child: Align(
                alignment: Alignment.center,
                child: Image(image: AssetImage('assets/img/nn.png'))
            ),
          ),

          SizedBox(
            height: 1,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'News App',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Style.Colors.maincolor),
            ),
          ),
        ],
      ),
    );
  }
}

