import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flame_konek/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


 
  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    Timer(
          Duration(seconds: 2),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home())));

    
  }

 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/app_logo.png'),
                fit: BoxFit.cover)),
      )),
    ));
  }
}
