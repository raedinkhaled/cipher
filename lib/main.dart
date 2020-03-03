import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:string_validator/string_validator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cesar Cipher',
      theme: ThemeData(
          primaryColor: Color(0xFF61C6AD),
          accentColor: Color(0xFFfdae5e),
          backgroundColor: Color(0xFF262833),
          brightness: Brightness.dark,
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
  String encrypt(String plainText, int shift) {
    if (shift < 0) {
      shift += 26;
    }

    String cipherText = '';

    for (int i = 0; i < plainText.length; i++) {
      var c = plainText[i];
      if (isAlpha(c)) {
        var code = plainText.codeUnitAt(i);
        // en cas ou le caractere est Majiscule
        if ((code >= 65) && (code <= 90)) {
          c = String.fromCharCode(((code - 65 + shift) % 26) + 65);
        }
        // Caractere Miniscule
        else if ((code >= 97) && (code <= 122)) {
          c = String.fromCharCode(((code - 97 + shift) % 26) + 97);
        }
      }

      cipherText += c;
    }

    return cipherText;
  }

  String decrypt(String plainText, int shift) {
    if (shift < 0) {
      shift += 26;
    }

    String cipherText = '';

    for (int i = 0; i < plainText.length; i++) {
      var c = plainText[i];
      if (isAlpha(c)) {
        var code = plainText.codeUnitAt(i);
        // en cas ou le caractere est Majiscule
        if ((code >= 65) && (code <= 90)) {
          c = String.fromCharCode(((code - 65 - shift) % 26) + 65);
        }
        // Caractere Miniscule
        else if ((code >= 97) && (code <= 122)) {
          c = String.fromCharCode(((code - 97 - shift) % 26) + 97);
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
      int decalage = toInt(myController2.text);
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
      int decalage = toInt(myController2.text);
      String output = decrypt(ourText, decalage);
      myController.text = output;
      _fileChoosen=false;
    });
  }

  void doJob3() async {
    try {
      File file =await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: 'txt');
      if (!mounted) return;
      if (await file.exists()) {
      contents = await file.readAsString();
      _fileChoosen = true;
    }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF262833),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Methode de Cesar:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: myController,
                  maxLines: 6,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Text en Clair',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: myController2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Decalage',
                      labelStyle: TextStyle(
                        color: Colors.white
                      )
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
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color(0xFF052029).withAlpha(100),
                                  offset: Offset(2, 4),
                                  blurRadius: 8,
                                  spreadRadius: 2)
                            ],
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
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color(0xFF052029).withAlpha(100),
                                  offset: Offset(2, 4),
                                  blurRadius: 8,
                                  spreadRadius: 2)
                            ],
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
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xFF052029).withAlpha(100),
                            offset: Offset(2, 4),
                            blurRadius: 8,
                            spreadRadius: 2)
                      ],
                      color: Color(0xFFfec689)),
                  child: Text(
                    'Choisissez un fichier',
                    style: TextStyle(fontSize: 20, color: Color(0xFF052029)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: myController3,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Text Chiffre',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Chiffrement/Dechiffrement: Methode de Cesar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
    );
  }
}
