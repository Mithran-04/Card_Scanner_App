import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_recognition/Helpers/db_helper.dart';
import 'package:text_recognition/details_screen.dart';
import 'App_Drawer.dart';
import 'AadhaarDetails_screen.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: DBHelper(),
      child: MaterialApp(
          title: 'Home',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: MyHomePage(),
          routes: {
            AadhaarListScreen.routeName: (ctx) => AadhaarListScreen(),
            MyHomePage.routeName: (ctx) => MyHomePage(),
          }
      ),
    );

  }
}
