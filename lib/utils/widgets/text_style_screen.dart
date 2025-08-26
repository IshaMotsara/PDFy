import 'package:flutter/material.dart';

class AppTextStyles {
static  const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white, // example
  );

    static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white, // example
  );
}

class AppBars {
  static AppBar defaultAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
       flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(164, 79, 12, 70),
              Color.fromARGB(152, 108, 18, 149),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
     //backgroundColor:  Color.fromARGB(119, 217, 100, 202), // matches gradient bg
      //foregroundColor: Colors.black,
       // icons & back button color
    );
  }
}