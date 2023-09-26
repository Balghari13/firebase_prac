import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pract/UI/home_page.dart';
import 'package:firebase_pract/UI/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final user = FirebaseAuth.instance.currentUser;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
if(user != null){
 Timer(const Duration(seconds: 3), (){
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
 });
}else{
  Timer(const Duration(seconds: 3), (){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
  });
}
}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text('Loading....', style: TextStyle(fontSize: 50),),));
  }
}
