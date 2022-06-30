import '../models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._instance;
  static Database? _database;

  final String tableName = 'contacts';
  final String colId = 'id';
  final String colName = 'name';
  final String colMobileNo = 'mobileNo';
  final String colEmail = 'email';
  final String colCompany = 'company';
  final String colPhoto = 'photo';

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  Future<Database?> initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'contact.db');
    return openDatabase(path, version: 1, onCreate: _create);
  }

  Future<void> _create(Database db, int version) async {
    var sql = '''
    CREATE TABLE $tableName(
      $colId INTEGER PRIMARY KEY,
      $colName TEXT,
      $colMobileNo TEXT,
      $colEmail TEXT,
      $colCompany TEXT,
      $colPhoto TEXT
    )
    ''';
    await db.execute(sql);
  }

  //save contact
  Future<int?> save(Contact contact) async {
    var client = await _db;
    return client!.insert(tableName, contact.toJson());
  }

  //get all contact
  Future<List?> getListContact() async {
    var client = await _db;
    var result = await client!.query(tableName,
        columns: [colId, colName, colMobileNo, colEmail, colCompany, colPhoto]);
    return result.toList();
  }

  //update
  Future<int?> update(Contact contact) async {
    var client = await _db;
    return await client!.update(tableName, contact.toJson(),
        where: '$colId=?', whereArgs: [contact.id]);
  }

  //delete
  Future<int?> delete(int id) async {
    var client = await _db;
    return await client!.delete(tableName, where: '$colId=?', whereArgs: [id]);
  }
}
