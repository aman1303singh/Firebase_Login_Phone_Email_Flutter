import 'package:email_phone_firebase/firebase_options.dart';
import 'package:email_phone_firebase/home.dart';
import 'package:email_phone_firebase/phone_auth/signin_Phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:(FirebaseAuth.instance.currentUser !=null) 
      ? const Home() 
      : const PhoneSignin(),// login()
    );
  }
}
