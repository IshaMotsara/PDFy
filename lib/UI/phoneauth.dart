import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sagar_new_project/UI/custom.dart';
import 'package:sagar_new_project/UI/otpscreen.dart';

class Phoneauth extends StatefulWidget {
  const Phoneauth({super.key});

  @override
  State<Phoneauth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<Phoneauth> {
  TextEditingController phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
     print("Phoneauth screen building...");
    return  Scaffold(
      backgroundColor: const Color(0xFF2C333A),
   appBar: AppBar(
    backgroundColor: const Color(0xFF2C333A),
     automaticallyImplyLeading: true, 
  title: const Text("Phone Auth",
  
  style: TextStyle(
    color:Colors.white
  ),),
 
  centerTitle: true,
   ),
   floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.fullscreen_exit),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/logout");
        }, 
      ),
   body:Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Custom.customTextField(phoneController,"Enter Phone Number",Icons.phone,false,TextInputType.phone),
      const SizedBox(height: 30,),
      ElevatedButton(onPressed: (){
        FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber:"+91 ${phoneController.text.toString()}",
          verificationCompleted:(PhoneAuthCredential credential){} ,
          verificationFailed: (FirebaseAuthException ex){
            log("Verification failed: ${ex.message}");
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Verification failed: ${ex.message}")),
  );
          },
          codeSent:(String verificationid,int? resendtoken){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> Otpscreen(verificationId: verificationid)));
          },
          codeAutoRetrievalTimeout:(String verificationId){},
        );
      },
      style:ElevatedButton.styleFrom(
      backgroundColor: Colors.yellow),
       child:const  Text("Verify Phone Number",
       style: TextStyle(
        color: Colors.black
       ),
       ),)
    ],
   )
    );
  }
}