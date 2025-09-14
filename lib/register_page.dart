import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/login_screen.dart';

class RegisterPage extends StatelessWidget{

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
                labelText: "Enter Email"
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Password"
              ),
            ),
            SizedBox(height: 40,),
            ElevatedButton(onPressed: () async {

              String mail = emailController.text.trim();
              String pass = passwordController.text.trim();

              if(mail.isEmpty || pass.isEmpty)
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter All The Fields!")));
                }
              else{
                try{
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: mail, password: pass).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Register Successfully!")));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));

                  },);
                }
                catch(err){
                  print(err);
                }
              }

            },style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent) ,child: Text("Register Now")),
            SizedBox(height: 20,),

            InkWell(onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            },
                child: Text("Already have an account? Click Here",style: TextStyle(color: Colors.red),))
          ],
        ),
      ),
    );
  }

}