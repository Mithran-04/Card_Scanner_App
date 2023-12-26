import 'package:flutter/material.dart';
import 'package:text_recognition/Helpers/db_helper.dart';
class UserDetails extends StatelessWidget {
  final AadhaarFormat dataModel;
  static const routeName = '/Details_user';
  const UserDetails({Key? key,required this.dataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              child: Text(
                "Name : ${dataModel.Name}",style: TextStyle(fontSize: 20.0,),textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(height: 10,),
          SizedBox(
            width: double.infinity,
            child: Container(
              child: Text(
                "Gender:  ${dataModel.Gender}",style: TextStyle(fontSize: 20.0),textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(height: 10,),
          SizedBox(
            width: double.infinity,
            child: Container(
              child: Text(
                "Date of Birth :  ${dataModel.DOB}",style: TextStyle(fontSize: 20.0),textAlign: TextAlign.left,
              ),
            ),
          ),

          SizedBox(height: 10,),
          SizedBox(
            width: double.infinity,
            child: Container(
              child: Text(
                "Aadhaar Number:  ${dataModel.AadhaarNo}",style: TextStyle(fontSize: 20.0),textAlign: TextAlign.left,
              ),
            ),
          ),


        ],
      ),
    );
  }
}
