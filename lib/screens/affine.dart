import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:string_validator/string_validator.dart';

class Affine extends StatefulWidget {
  @override
  _AffineState createState() => _AffineState();
}

class _AffineState extends State<Affine> {
  bool isCoprime;
  @override
  void initState() {
    isCoprime = true;
    super.initState();
  }

  String encrypt(String plainText, int shiftA, int shiftB) {
   if (shiftA < 0) {
      shiftA += 26;
    }
    if (shiftB < 0) {
      shiftB += 26;
    }

    String cipherText = '';

    for (int i = 0; i < plainText.length; i++) {
      var c = plainText[i];
      if (isAlpha(c)) {
        var code = plainText.codeUnitAt(i);
        // en cas ou le caractere est Majiscule
        if ((code >= 65) && (code <= 90)) {
          c = String.fromCharCode(((((code - 65) * shiftA) + shiftB) % 26) + 65);
        }
        // Caractere Miniscule
        else if ((code >= 97) && (code <= 122)) {
          c = String.fromCharCode(((((code - 97) * shiftA) + shiftB) % 26) + 97);
        }
      }

      cipherText += c;
    }

    return cipherText;
  }

  String decrypt(String plainText, int shiftA, int shiftB) {
    if (shiftA < 0) {
      shiftA += 26;
    }
    if (shiftB < 0) {
      shiftB += 26;
    }

    String cipherText = '';

    int invA=0;
    int pgcd = 0;
    for(int i = 0; i<26 ; i++){
      pgcd=(shiftA*i)%26;
      if ( pgcd == 1){
        invA = i;
      }
    }

    for (int i = 0; i < plainText.length; i++) {
      var c = plainText[i];
      if (isAlpha(c)) {
        var code = plainText.codeUnitAt(i);
        // en cas ou le caractere est Majiscule
        if ((code >= 65) && (code <= 90)) {
          c = String.fromCharCode( ((((code-65) - shiftB) * invA) % 26) + 65 );
        }
        // Caractere Miniscule
        else if ((code >= 97) && (code <= 122)) {
          c = String.fromCharCode( ((((code-97) - shiftB) * invA) % 26) + 97 );
        }
      }

      cipherText += c;
    }

    return cipherText;
  }

  int gcd(int a, int b) {
    if (a == 0 || b == 0) {
      return 0;
    }
    if (a == b) {
      return a;
    }
    if (a > b) {
      return gcd(a - b, b);
    }

    return gcd(a, b - a);
  }

  bool coprime(int a, int b) {
    if (gcd(a, b) == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool _fileChoosen = false;
  // BEGIN CONTROLLER FOR Clair Text
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
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
      int decalageA;
      decalageA = int.parse(myController2.text);
      int decalageB;
      decalageB = int.parse(myController4.text);
      String output = encrypt(ourText, decalageA, decalageB);
      myController3.text = output;
      _fileChoosen = false;
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
      int decalageA;
      decalageA = int.parse(myController2.text);
      int decalageB;
      decalageB = int.parse(myController4.text);
      String output = decrypt(ourText, decalageA, decalageB);
      myController.text = output;
      _fileChoosen = false;
    });
  }

  String isChoosen = "";

  void doJob3() async {
    try {
      File file =
          await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: 'txt');
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
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Affine Cipher"),
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Text en Clair',
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: myController2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: 'Valeur de A',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: myController4,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: 'Valeur de B',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  isCoprime
                      ? SizedBox(height: 1)
                      : Text(
                          'A doit être choisi de telle sorte que a et 26 soient des nombres premiers entre eux',
                          style: TextStyle(color: Colors.red),
                        ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (coprime(int.parse(myController2.text), 26)) {
                              setState(() {
                                isCoprime = true;
                              });
                              doJob();
                            } else {
                              setState(() {
                                isCoprime = false;
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.symmetric(vertical: 13),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Color(0xFFfec689)),
                            child: Text(
                              'Chiffrer',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFF262833)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (coprime(int.parse(myController2.text), 26)) {
                              setState(() {
                                isCoprime = true;
                              });
                              doJob2();
                            } else {
                              setState(() {
                                isCoprime = false;
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.symmetric(vertical: 13),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Color(0xFFfec689)),
                            child: Text(
                              'Dechiffrer',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFF262833)),
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
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF052029)),
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
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
                          color: Color(0xFFfdae5e)),
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
