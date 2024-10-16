// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:email_phone_firebase/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  final String verificationId;
  const Otp({super.key, required this.verificationId});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController = TextEditingController();

  Future<void> verifyOtp() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>const Home()));
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString() as num);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter OTP"),
            const SizedBox(
              height: 2,
            ),
            TextField(
              maxLength: 6,
              controller: otpController,
              decoration:
                  const InputDecoration(hintText: '638638', counterText: ""),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
                child: CupertinoButton(
                    child: const Text("Verify"),
                    onPressed: () {
                      verifyOtp();
                    }))
          ],
        ),
      ),
    );
  }
}
