
import 'dart:developer';
import 'package:PDFY/utils/widgets/common_widget.dart';
import 'package:PDFY/utils/widgets/gradient_background_screen.dart';
import 'package:PDFY/utils/widgets/text_style_screen.dart';
import 'package:PDFY/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  String verificationId;
   OtpScreen({super.key,required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<OtpScreen> {
  TextEditingController otpController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  GradientBackground(
      child: Scaffold(
         backgroundColor: Colors.transparent,
       appBar: AppBars.defaultAppBar(),
         body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Custom.customTextField(otpController,"Enter The Otp",Icons.phone,false,TextInputType.phone),
         const SizedBox(height: 5,),
         SizedBox(
          height: 5,
         ),
         Custom.customButton(onPressed: ()async{
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
         text:"OTP"
      ),
      ],
        ),
      ),
    );
  }
}