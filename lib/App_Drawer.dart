import 'package:flutter/material.dart';
import 'package:text_recognition/home_screen.dart';
import 'AadhaarDetails_screen.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        AppBar(title: Text('Options'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.description),
          title: Text('Aadhaar List'),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(AadhaarListScreen.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.list),
          title: Text('Scan Aadhaar'),
          onTap: (){
            Navigator.of(context).pushReplacementNamed(MyHomePage.routeName);
          },
        ),
      ]
      ),

    );
  }
}
