import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection{
  Future<Database> setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'velozity.db');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }
  Future<void> _createDatabase(Database database, int version) async{
    String sql = "CREATE TABLE user (id INTEGER PRIMARY KEY,name TEXT,email TEXT);";
    String sql2 = "CREATE TABLE patient (id INTEGER PRIMARY KEY,patientid TEXT,patientname TEXT,patientemail TEXT,patientage TEXT,patientgender TEXT,patientmaritalstatus TEXT,hand TEXT,finger TEXT,foot TEXT,arm TEXT,leg TEXT,neck TEXT,back TEXT);";
    await database.execute(sql);
    await database.execute(sql2);
  }

}