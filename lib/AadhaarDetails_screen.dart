import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_recognition/Helpers/db_helper.dart';
import 'package:text_recognition/details_screen.dart';
import 'App_Drawer.dart';


class AadhaarListScreen extends StatefulWidget {
  static const routeName = '/listUser';

  @override
  State<AadhaarListScreen> createState() => _AadhaarListScreenState();
}

class _AadhaarListScreenState extends State<AadhaarListScreen> {
 _showSuccessSnackBar(String message){
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text(message),),
   );
 }
  _deleteFormDialog(BuildContext context,userId){
       return showDialog(context: context, builder: (_){
         return AlertDialog(
           title: Text('Are you sure you want to delete!',
           style: TextStyle(color: Colors.teal,fontSize: 15),),
           actions: [
             TextButton(
               style: TextButton.styleFrom(
                 primary: Colors.white,
                 backgroundColor: Colors.red
               ),
                 onPressed: () async{
                 var result=await  DBHelper.delete("AadhaarNewDb", userId);
                 print("Resulttttttttttttttttt $result");
                 if(result != null){
                   Navigator.pop(context);
                   _showSuccessSnackBar(
                     'Deleted Successfully'
                   );
                   setState(() {});
                 }
                 }, child: const Text('Yes')
             ),
             TextButton(
                 style: TextButton.styleFrom(
                     primary: Colors.white,
                     backgroundColor: Colors.teal
                 ),
                 onPressed: (){Navigator.pop(context);},
                 child: const Text('No')
             ),
           ],
         );
       });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details List'),

      ),
        drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<DBHelper>(context, listen: false)
            .fetchAndSet(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
            ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<DBHelper>(
          child: Center(
            child: const Text('No Information yet!!'),
          ),
          builder: (ctx, profile, ch) => profile.items.length <= 0
              ? ch!
              : ListView.builder(
            itemCount: profile.items.length,
            itemBuilder: (ctx, i) => Card(
              elevation: 6,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(Icons.person),
                    title: Text(profile.items[i].Name!, style: TextStyle(fontSize: 20.0,),),

                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserDetails(dataModel: profile.items[i],)));
                    },
                trailing: IconButton(
                  onPressed:() async{
                    print("IDDDDDDDD now         $profile.items[i].id ");
                      _deleteFormDialog(context,profile.items[i].id);
                  },
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,),
              ),
            ),

                  ),
            ),

              )






    );
  }
}