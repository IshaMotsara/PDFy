import 'dart:developer';
import 'package:PDFY/utils/widgets/common_widget.dart';
import 'package:PDFY/utils/widgets/gradient_background_screen.dart';
import 'package:PDFY/utils/widgets/text_style_screen.dart';
import 'package:PDFY/views/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneauthState();
}

class _PhoneauthState extends State<PhoneAuth> {
  TextEditingController phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
     print("Phoneauth screen building...");
    return  GradientBackground(
      child: Scaffold(
         backgroundColor: Colors.transparent,
         appBar: AppBars.defaultAppBar(),
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
        Custom.customButton(onPressed: (){
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
              Navigator.push(context,MaterialPageRoute(builder: (context)=> OtpScreen(verificationId: verificationid)));
            },
            codeAutoRetrievalTimeout:(String verificationId){},
          );
        },
        text: "Verify Phone Number"
       ),
      ],
         )
      ),
    );
  }
}