import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:app_breath/Models/Dados.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;
 
  DatabaseHelper._createInstance();
   factory DatabaseHelper(){
     if(_databaseHelper==null){
       _databaseHelper = DatabaseHelper._createInstance();
     }
     return _databaseHelper;
   }
   Future<Database> get database async{
     if (_database == null){
       _database = await initializeDatabase();
     }
     return _database;
   }
  Future<Database> initializeDatabase() async{
  Directory directory = await getApplicationDocumentsDirectory();
  print(directory);
  String path = directory.path +"Data/Respirador.db";
  print(path);
  var dadosDatabase = await openDatabase(path,version:1);
  return dadosDatabase;
  }

  Future<Dados> getItems(int timestamp) async{
    Database db = await this.database;
    List<Map> maps = await db.query("Dados",columns: ["timestamp","nivel_oxi","quant_oxi","resp","graph"],where: "timestamp >= ?", whereArgs: [timestamp]);

    if(maps.length>0){
      return Dados.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<Dados> deleteItems() async{

  }
}
