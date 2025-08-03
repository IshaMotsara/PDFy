
import 'dart:developer';
import 'package:sagar_new_project/UI/custom.dart';
import 'package:sagar_new_project/UI/profilescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Otpscreen extends StatefulWidget {
  String verificationId;
   Otpscreen({super.key,required this.verificationId});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController otpController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
 appBar: AppBar(
  title: const Text("OTP Screen"),
  centerTitle: true,
  ),
  body:  Column(
    children: [
   Custom.customTextField(otpController,"Enter The Otp",Icons.phone,false,TextInputType.phone),
   const SizedBox(height: 5,),
   ElevatedButton(onPressed: ()async{
    try{
      PhoneAuthCredential credential=
       PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text.toString());
       await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
    }catch(ex){
      log(ex.toString());
    }
   },
    child: const Text("OTP"))
    ],
  ),
    );
  }
}