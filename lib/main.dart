import 'package:CaesarCipher/screens/caesar.dart';
import 'package:CaesarCipher/screens/vigenere.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:string_validator/string_validator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application. 0796120144
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cesar Cipher',
      theme: ThemeData(
          primaryColor: Color(0xFF262833),
          accentColor: Color(0xFFfdae5e),
          //backgroundColor: Color(0xFF262833),
          fontFamily: 'NunitoSans'),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: <Widget>[
         Container(
           child: Text("Choose One of the Following:",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 17
           ),),
         ),
         GestureDetector(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> CaesarUI()));
           },
                    child: Container(
                          margin: EdgeInsets.all(20.0),

                          padding: EdgeInsets.symmetric(vertical: 13),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                             
                              color: Color(0xFFfec689)),
                          child: Text(
                            'Caesar Cipher',
                            style:
                                TextStyle(fontSize: 20, color: Color(0xFF262833)),
                          ),
                        ),
         ),
         GestureDetector(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> Vigenere()));
           },
                    child: Container(
                          margin: EdgeInsets.symmetric(horizontal:20.0),

                          padding: EdgeInsets.symmetric(vertical: 13),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                             
                              color: Color(0xFF262833)),
                          child: Text(
                            'Vigenere Cipher',
                            style:
                                TextStyle(fontSize: 20, color: Color(0xFFfec689)),
                          ),
                        ),
         )
       ],
     ),
   );
  }
}