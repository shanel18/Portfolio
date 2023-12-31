import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flame_konek/screens/auth.dart';
import 'package:flame_konek/screens/login_or_register.dart';
import 'package:flame_konek/screens/login_page.dart';
import 'package:flame_konek/screens/register_page.dart';
import 'package:flame_konek/screens/splash.dart';
import 'package:flutter/material.dart';


final usersRef = FirebaseFirestore.instance.collection('Users');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: AuthPage(),
    );
  }
}

