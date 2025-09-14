import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/home_screen.dart';
import 'package:flutter_firebase/otp_screen.dart';
import 'package:flutter_firebase/register_page.dart';

class LoginPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Email",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Password",
              ),
            ),
            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                String mail = emailController.text.trim();
                String pass = passwordController.text.trim();

                if (mail.isEmpty || pass.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enter All the Fields!")),
                  );
                } else {
                  try {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(email: mail, password: pass)
                        .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login Successfully!")),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        });
                  } on FirebaseAuth catch (err) {
                    print(err);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: Text("Login Now"),
            ),
            SizedBox(height: 20),

            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(
                "Don't have an account? Click Here",
                style: TextStyle(color: Colors.red),
              ),
            ),

            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Phone Number",
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException ex) {},
                  codeSent: (String verificationId, int? resendToken) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(verificationid: verificationId),));
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                  phoneNumber: phoneController.text.toString(),
                );
              },
              child: Text("Verify phone Number"),
            ),
          ],
        ),
      ),
    );
  }
}
