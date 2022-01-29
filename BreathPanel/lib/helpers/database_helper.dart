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
    timestamp double not null primary key,
    porc_oxi float not null,
    pressao_max float not null,
    porc_pausa float not null, 
    volume_tidal float not null,
    frequencia float not null,
    peep float not null,
    temp_insp float not null,
    pressao float not null,
    fluxo float not null
    )""");
 }

  Future insertItems(Dados dados) async{
    Database db = await this.database;
    await db.insert("Dados", dados.toMap());
  }

  Future<List<Dados>> getItems(double timestamp) async{
    Database db = await this.database;
    
    var res = await db.query("Dados",columns: ["timestamp","porc_oxi","pressao_max","porc_pausa","volume_tidal","frequencia","peep","temp_insp","pressao","fluxo"],where: "timestamp >= ?", whereArgs: [timestamp]);
    List<Dados> lista = res.isNotEmpty ? res.map((d) => Dados.fromMap(d)).toList() : null;
    return lista;
  }

  Future<int> deleteItems(double timestamp) async{
    var db = await this.database;

    int result = await db.delete("Dados",where: "timestamp <= ?",whereArgs: [timestamp]);
    return result;
  }
  Future close() async{
    Database db = await this.database;
    db.close();
  }
  Future<String> deleteDB() async {
    Database db = await this.database;
    db.execute("DROP TABLE Dados");
    return "deletado com sucesso";
  }
}
