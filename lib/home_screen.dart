import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_recognition/Helpers/db_helper.dart';
import 'package:text_recognition/details_screen.dart';
import 'App_Drawer.dart';
import 'AadhaarDetails_screen.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/HomeUser';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool textScanning = false;
  List<String> detailsList=[];

  XFile? imageFile;

  String scannedText = "";
  String newText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Aadhaar Scan App"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.description),
        //     onPressed: () {
        //       Navigator.of(context).pushNamed(AadhaarListScreen.routeName);
        //     },
        //   ),
        // ],

      ),
      drawer: AppDrawer(),
      body: Center(
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (textScanning) const CircularProgressIndicator(),
                    if (!textScanning && imageFile == null)
                      Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey[300]!,
                      ),
                    if (imageFile != null) Image.file(File(imageFile!.path)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.grey,
                                shadowColor: Colors.grey[400],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {
                                getImage(ImageSource.gallery);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 30,
                                    ),
                                    Text(
                                      "Gallery",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.grey,
                                shadowColor: Colors.grey[400],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {
                                getImage(ImageSource.camera);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                    ),
                                    Text(
                                      "Camera",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.grey,
                                shadowColor: Colors.grey[400],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {
                                saveDetails();
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.save,
                                      size: 30,
                                    ),
                                    Text(
                                      "Save",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // " $detailsList[0], $detailsList[1],  $detailsList[2], $detailsList[3]"
                    Container(

                      child: Text(
                        scannedText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                )),
          )),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occurred while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    detailsList=[];
    var id1=0,id2=0,ct=0;
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        ct+=1;
        scannedText = scannedText + " "+ line.text ;
        detailsList.add(line.text);
        newText=newText+line.text+" ";
      }
    }
    id1=scannedText.indexOf("DOB");
    // String temp=scannedText.substring(id1+5);
    detailsList[1]=scannedText.substring(id1+4,id1+4+12);
    // detailsList[3]=detailsList[ct-3];
    if(scannedText.indexOf("MALE")!=-1 || scannedText.indexOf("Male")!=-1)
            { if(scannedText.indexOf("Male")!=-1)
                     { id2=scannedText.indexOf("Male");
                       detailsList[3]=scannedText.substring(id2+5,id2+5+14);
                     }
              else{
              id2=scannedText.indexOf("MALE");
              detailsList[3]=scannedText.substring(id2+5,id2+5+14);
            }
              detailsList[2]="MALE";
            }
    else {
      if (scannedText.indexOf("Female") != -1) {
        id2 = scannedText.indexOf("Female");
        detailsList[3] = scannedText.substring(id2 + 7, id2 + 7 + 14);
      }
      else {
        id2 = scannedText.indexOf("FEMALE");
        detailsList[3] = scannedText.substring(id2 + 7, id2 + 7 + 14);
      }


      detailsList[2] = "FEMALE";
    }


    print("Hellloooooooooooooooooooooooooooooooo00000000000000000000000");

    print(detailsList[0]);
    print(detailsList[1]);
    print(detailsList[2]);
    print(detailsList[3]);
    scannedText= "$detailsList[0], $detailsList[1],  $detailsList[2], $detailsList[3]";
    print(id2);

    textScanning = false;
    setState(() {});
  }


  void saveDetails() async{

    DBHelper.insert('AadhaarNewDb',{'id':DateTime.now().toString(),'Name': detailsList[0],'DOB':detailsList[1],'Gender':detailsList[2],'AadhaarNo': detailsList[3]});
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
  }
}
