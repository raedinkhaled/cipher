import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:string_validator/string_validator.dart';


class Vigenere extends StatefulWidget {
  @override
  _VigenereState createState() => _VigenereState();
}

class _VigenereState extends State<Vigenere> {


   String encrypt(String plainText, String shift) {
     while(shift.length<plainText.length){
       shift+=shift;
     }

    String cipherText = '';

    for (int i = 0; i < plainText.length; i++) {
      var c = plainText[i];
      if (isAlpha(c)) {
        var code = plainText.codeUnitAt(i);
        if(isLowercase(c)){
          shift = shift.toLowerCase();
        }
        else if(isUppercase(c)){
          shift = shift.toUpperCase();
        }
        var shiftCode= shift.codeUnitAt(i);
        // en cas ou le caractere est Majiscule
        if ((code >= 65) && (code <= 90)) {
          c = String.fromCharCode(((code - 65 + shiftCode-65) % 26) + 65);
        }
        // Caractere Miniscule
        else if ((code >= 97) && (code <= 122)) {
          c = String.fromCharCode(((code-97 + shiftCode-97) % 26) + 97);
        }
      }

      cipherText += c;
    }

    return cipherText;
  }

  String decrypt(String plainText, String shift) {
    while(shift.length<plainText.length){
       shift+=shift;
     }

    String cipherText = '';

    for (int i = 0; i < plainText.length; i++) {
      var c = plainText[i];
      if (isAlpha(c)) {
        var code = plainText.codeUnitAt(i);
        if(isLowercase(c)){
          shift = shift.toLowerCase();
        }
        else if(isUppercase(c)){
          shift = shift.toUpperCase();
        }
        var shiftCode= shift.codeUnitAt(i);
        // en cas ou le caractere est Majiscule
        if ((code >= 65) && (code <= 90)) {
          c = String.fromCharCode(((code - 65 - (shiftCode-65)) % 26) + 65);
        }
        // Caractere Miniscule
        else if ((code >= 97) && (code <= 122)) {
          c = String.fromCharCode(((code - 97 - (shiftCode-97)) % 26) + 97);
        }
      }

      cipherText += c;
    }

    return cipherText;
  }
bool _fileChoosen = false;
  // BEGIN CONTROLLER FOR Clair Text
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    myController3.dispose();
    super.dispose();
  }

  //END CONTROLLER FOR Clair Text
  
  String contents;
  void doJob() {
    setState(() {
      String ourText = "";
      if (_fileChoosen) {
        ourText = contents;
        myController.text = contents;
      } else {
        ourText = myController.text;
      }
      String decalage="";
      decalage = myController2.text;
      String output = encrypt(ourText, decalage);
      myController3.text = output;
      _fileChoosen=false;
    });
  }

  void doJob2() {
    setState(() {
      String ourText = "";
      if (_fileChoosen) {
        ourText = contents;
        myController3.text = contents;
      } else {
        ourText = myController3.text;
      }
      String decalage = myController2.text;
      String output = decrypt(ourText, decalage);
      myController.text = output;
      _fileChoosen=false;
    });
  }

String isChoosen="";

  void doJob3() async {
    try {
      File file =await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: 'txt');
      if (await file.exists()) {
      contents = await file.readAsString();
      _fileChoosen = true;
    }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
            isChoosen = "File Uploaded Successfuly";
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
          child: Scaffold(
        appBar: AppBar(
          title: Text("Vigenere Cipher"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
                        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: myController,
                      maxLines: 6,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        labelText: 'Text en Clair',
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: myController2,
                      decoration: InputDecoration(
                        
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                          ), labelText: 'Decalage',
                          ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            doJob();
                          },
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.symmetric(vertical: 13),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Color(0xFFfec689)),
                            child: Text(
                              'Chiffrer',
                              style:
                                  TextStyle(fontSize: 20, color: Color(0xFF262833)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            doJob2();
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.symmetric(vertical: 13),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: Color(0xFFfec689)),
                            child: Text(
                              'Dechiffrer',
                              style:
                                  TextStyle(fontSize: 20, color: Color(0xFF262833)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      doJob3();
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.symmetric(vertical: 13),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xFFfec689)),
                      child: Text(
                        'Choisissez un fichier',
                        style: TextStyle(fontSize: 20, color: Color(0xFF052029)),
                      ),
                    ),
                  ),
                  Text(isChoosen),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: myController3,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        labelText: 'Text Chiffre',
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Raedin Khaled Sakhri',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFfdae5e)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'G2',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}