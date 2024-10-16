// ignore_for_file: non_constant_identifier_names

import 'package:email_phone_firebase/phone_auth/signin_Phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  void Logout() {
   FirebaseAuth.instance.signOut();
   Navigator.popUntil(context, (route) => route.isFirst);
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PhoneSignin()
   //Login()
   ));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text("Home"),
        actions:  [
          IconButton(onPressed: () { Logout();}, icon:const Icon(Icons.logout))
        ],
      ),
    );
  }
}