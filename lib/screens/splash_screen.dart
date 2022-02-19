import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:news_test_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
     Timer(const Duration(seconds: 3), (){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const HomeScreen()));
       
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body:Center(
        child: SizedBox(
  width: 250.0,
  child: DefaultTextStyle(
    style: const TextStyle(
        fontSize: 20.0,
    
    ),
    child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText('Welcome to news app'),
        
        ],
        onTap: () {
          print("Tap Event");
        },
    ),
  ),
),
      ),
    );
  }
}