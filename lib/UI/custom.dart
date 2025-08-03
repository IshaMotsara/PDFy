import 'package:flutter/material.dart';

class Custom{
  static customTextField(TextEditingController controller,String text,IconData iconData,bool toHide, TextInputType keyboardType){
return TextField(
  controller:controller,
   keyboardType: keyboardType,
  obscureText:toHide,
  style:const TextStyle(color: Colors.white),
  decoration: InputDecoration(
    hintText:text,
    hintStyle: const TextStyle(
      color: Colors.white
    ),
    
    suffixIcon:Icon(iconData,color: Colors.white,),
    border:OutlineInputBorder(
      borderRadius: BorderRadius.circular(25)
    )
  )
  );
}

static customButton(VoidCallback voidCallback,String text){
  return 
   SizedBox(
 height:50,
   width:200,
  child:ElevatedButton(
    onPressed: voidCallback ?? () {},
    style:ElevatedButton.styleFrom(
      backgroundColor: Colors.yellow
    ),
child: Text(text,
style: const TextStyle(
      color: Colors.black,
    ),

),),
);}

static CustomAlertBox(BuildContext context,String text){
  return showDialog(context: context, builder: (BuildContext context){
  return AlertDialog(
    title: Text(text,
    style: const TextStyle(
      color:Colors.white,
      backgroundColor: Colors.blueAccent
    ),
    ),
  );
  });
}

static elevatedbutton(VoidCallback?onPressed,String text){
ElevatedButton(
    onPressed: onPressed ?? () {},
    style:ElevatedButton.styleFrom(
      backgroundColor: Colors.yellow
    ),
child: Text(text,
style: const TextStyle(
      color: Colors.black,
    ),

),);
}


  }




