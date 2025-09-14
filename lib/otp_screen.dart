import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/home_screen.dart';

class OtpScreen extends StatefulWidget {
  String verificationid;

  OtpScreen({super.key, required this.verificationid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Verification"), centerTitle: true),
      body: Column(
        children: [
          TextField(
            controller: otpController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter OTP",
            ),
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                PhoneAuthCredential credential =
                    await PhoneAuthProvider.credential(
                      verificationId: widget.verificationid,
                      smsCode: otpController.text.toString(),
                    );
                FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                },);
              } catch (ex) {
                log(ex.toString() as num);
              }
            },
            child: Text("OTP"),
          ),
        ],
      ),
    );
  }
}
