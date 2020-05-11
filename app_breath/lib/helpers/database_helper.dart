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
  var dadosDatabase = await openDatabase(path,version:1, onCreate: _createDb);
  return dadosDatabase;
  }

 void _createDb(Database db, int newVersion) async{
   await db.execute("""CREATE TABLE IF NOT EXISTS Dados(
    timestamp int not null primary key,
    graph_pressao float not null,
    fluxo float not null,
    volume_tidal float not null, 
    frequencia float not null,
    oxigenio float not null,
    pressao_max float not null,
    peep float not null,
    tempo_insp float not null,
    perc_pausa float not null
    )""");
 }

  Future insertItems(Dados dados) async{
    Database db = await this.database;
    var result = await db.insert("Dados", dados.toMap());
    print(result);
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

  Future<Dados> deleteItems(int timestamp) async{
    var db = await this.database;

    int result = await db.delete("Dados",where: "timestamp <= $timestamp");
  }
  Future close() async{
    Database db = await this.database;
    db.close();
  }
}
