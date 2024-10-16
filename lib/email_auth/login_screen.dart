// ignore_for_file: use_build_context_synchronously, avoid_print, non_constant_identifier_names

import 'dart:math';

import 'package:email_phone_firebase/email_auth/signup_screen.dart';
import 'package:email_phone_firebase/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> Login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      print("Please fill all the detailes");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) =>const Home()));
        }
      } on FirebaseAuthException catch (e) {
        log(e.code.toString() as num);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Emal"),
              const SizedBox(
                height: 5,
              ),
               TextField(
                controller: emailController,
                decoration:const InputDecoration(hintText: 'exmple@.com'),
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
                decoration:const InputDecoration(hintText: '********'),
              ),
              Center(
                  child: CupertinoButton(
                      child: const Text('Login'), onPressed: () {Login();})),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don`t have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signup()));
                      },
                      child: const Text("Signup"))
                ],
              )
            ],
          )),
    );
  }
}
