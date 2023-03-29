import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLocalRepo{

  //create Table
  static Future<void> createTables(Database database) async{
    await database.execute(
      "CREATE TABLE record_jalan( id INTEGER PRIMARY KEY AUTOINCREMENT,nik INTEGER NOT NULL,langkah_jalan INTEGER NOT NULL, record DATETIME NOT NULL)"
    );
  }

  static Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(join(path, 'myDarlingLocalDB'), onCreate: (Database db, int version) async{
      await createTables(db);
    });
  }
}