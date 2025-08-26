import 'package:flutter/material.dart';

class Custom {
  /// Custom text field
  static Widget customTextField(
      TextEditingController controller,
      String text,
      IconData iconData,
      bool toHide,
      TextInputType keyboardType) {
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: toHide,
        style: const TextStyle(color: Colors.white,
       fontSize: 18,
        ), // use black text for readability
        decoration: InputDecoration(
          
          //hoverColor:  const Color.fromARGB(255, 237, 143, 171),
          hintText: text,
          fillColor:  const Color.fromARGB(193, 243, 163, 187),
        
          hintStyle: const TextStyle(color: Colors.white),
          suffixIcon: Icon(iconData, color:  Colors.purple),
         
          enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color:Color.fromARGB(255, 237, 143, 171), width: 2),
        ),
          focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.white,width: 0),
      ),
        ),
        
      ),
    );
    
  }

  /// Custom button
static Widget customButton({
  required VoidCallback? onPressed,
  required String text,}) {
  return SizedBox(
    height: 50,
    width: 300,
     child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(119, 217, 100, 202), // soft lavender
            Color.fromARGB(120, 193, 116, 229), // pastel gray-purple
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    
    
      child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white, // text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),),
  );
}


  /// Alert box
  static Future<void> customAlertBox(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Color.fromARGB(207, 152, 42, 137),
          backgroundColor: Colors.blueAccent,
          title: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  /// Another button (but you forgot return before)
  static Widget elevatedButton(VoidCallback? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  // ✅ Custom AlertBox
  
}
