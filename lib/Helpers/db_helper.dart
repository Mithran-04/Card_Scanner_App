import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class AadhaarFormat{
  final String? id;
  final String? Name;
  final String? DOB;
  final String? Gender;
  final String? AadhaarNo;

  AadhaarFormat({
    @required this.id,
    @required this.Name,
    @required this.DOB,
    @required this.Gender,
    @required this.AadhaarNo,
  });

}
class DBHelper with ChangeNotifier{
  List<AadhaarFormat> _items=[];

  List<AadhaarFormat> get items {
    return [..._items];
  }

  static Future<sql.Database> database() async{
    final dbPath=await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath,'AadhaarNewDb.db'),
        onCreate: (db,version){
           return db.execute(
               'CREATE TABLE AadhaarNewDb(id TEXT PRIMARY KEY,Name TEXT,DOB text,Gender text,AadhaarNo text)');
    },version: 1);
  }

  static Future<void> insert(String table,Map<String, Object> data) async{
    final db= await DBHelper.database();
    db.insert(table,data,conflictAlgorithm: sql.ConflictAlgorithm.replace,);
    print("IDDDDDDDD  success");

  }

  static Future<int?> delete(String table,String id) async{
    final db= await DBHelper.database();
    print("IDDDDDDDDDDDDDDDDDDDDD Now $id");
    // 'DELETE FROM Test WHERE name = ?', ['another name']);
    return await db.rawDelete('delete from AadhaarNewDb where id= ?',[id]);

  }

  static Future<List<Map<String, dynamic>>> getData(String table) async{
    final db= await DBHelper.database();
    return(db.query(table));
    // _items=dataList.map(
    //         (item)=> AadhaarFormat(
    //             Name: item['Name'],DOB: item['DOB'],Gender: item['Gender'],AadhaarNo: item['AadhaarNo'],
    //         )
    // )
    //     .toList();

  }
  Future<void> fetchAndSet() async {
    final dataList = await DBHelper.getData('AadhaarNewDb');
    _items = (await dataList)
        .map(
          (item) => AadhaarFormat(
            id: item['id'],
            Name: item['Name'],DOB: item['DOB'],Gender: item['Gender'],AadhaarNo: item['AadhaarNo'],
      ),
    )
        .toList();
    notifyListeners();
  }

}
