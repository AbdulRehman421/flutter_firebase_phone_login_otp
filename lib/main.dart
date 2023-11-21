import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_otp/phone.dart';
import 'package:firebase_phone_otp/verify.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
    },
  ));
}
