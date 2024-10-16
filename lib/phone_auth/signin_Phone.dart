import 'dart:math';

import 'package:email_phone_firebase/phone_auth/phone_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneSignin extends StatefulWidget {
  const PhoneSignin({super.key});

  @override
  State<PhoneSignin> createState() => _PhoneSigninState();
}

class _PhoneSigninState extends State<PhoneSignin> {
  TextEditingController phoneController = TextEditingController();

  void sendOtp() async {
    String phone = "+91${phoneController.text.trim()}";

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, resendToken) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Otp(
                      verificationId: verificationId,
                    )));
      },
      verificationCompleted: (credential) {},
      verificationFailed: (ex) {
        log(ex.code.toString() as num);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: const Duration(seconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Signin"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter Phone Number"),
            const SizedBox(
              height: 2,
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(hintText: '6386381'),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
                child: CupertinoButton(
                    color: Colors.blue,
                    onPressed: () {
                      sendOtp();
                    },
                    child:const Text("Signin")))
          ],
        ),
      ),
    );
  }
}
