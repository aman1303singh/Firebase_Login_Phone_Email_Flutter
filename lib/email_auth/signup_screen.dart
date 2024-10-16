// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  Future<void> createaccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cpassword = cpasswordController.text.trim();

    if (email == "" || password == "" || cpassword == "") {
      print("Please fill all the detailes");
    } else if (password != cpassword) {
      print("Password don`t match");
    } else {
     try {
       UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
         if(userCredential.user !=null) {
          Navigator.pop(context);
         }
     }on FirebaseAuthException catch (e) {
       log(e.code.toString() as num);
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create an account"),
        centerTitle: true,
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Email"),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'exmple@.com'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Password"),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: '********'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(" Confirm Password"),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: cpasswordController,
                decoration: const InputDecoration(hintText: '********'),
              ),
              Center(
                  child: CupertinoButton(
                      onPressed: () {createaccount();},
                      child: const Text('Create  account'))),
            ],
          )),
    );
  }
}
