import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:timugo_client_app/models/dataClient_models.dart';

class ClientDB {

  ClientDB._();

  static final ClientDB db = ClientDB._();
  Database _database;

  //Para evitar que abra varias conexiones una y otra vez.
  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "client.db");
    return await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Client ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "lastName TEXT,"
        "address TEXT,"
        "email TEXT,"
        "birthdate TEXT,"
        "phone INTEGER,"
        "token TEXT"
        ")");
      });
  }

  //Se obtienen todos los clientes guardados
  Future<List<DataClient>> getClient() async {

    final db = await database;
    var response = await db.query("Client");
    List<DataClient> list = response.map((c) => DataClient.fromMap(c)).toList();
    return list;  
  }

  //Se agrega un cliente a la base de datos
  addClient(DataClient client) async {
    final db = await database;
    var raw = await db.insert(
      "Client",
      client.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(raw);
    print("client added");
    return raw;
  }

  //Se eliminan todos los registros
  deleteClient() async {
    final db = await database;
    db.delete("Client");
  }

  // Database db;

  // Future initDB() async {
  //   db = await openDatabase(
  //     'timugoUser.db',
  //     version: 1,
  //     onCreate: (Database dbase, int version){
  //       dbase.execute("CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, lastName TEXT, address TEXT, email TEXT, birthdate TEXT, phone INTEGER, token TEXT )");      
  //     }
  //   );

  //   print("DB INITIALIZED");
  // }

  // insertUser(DataUser user) async {
  //   print(await db.insert("user", user.toMap()));
  // }

  // Future<List<DataUser>> getUser() async {
  //   List<Map<String, dynamic>> results = await db.query("user");

  //   return results.map((map) => DataUser.fromMap(map));
  // }

}