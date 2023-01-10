import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const table      = 'tbl_user';
  static const tableList  = 'tbl_note';

  // tbl user
  static const columnId   = '_id';
  static const namaDepan  = 'namaDepan';
  static const namaBlkng  = 'namaBlkng';
  static const email      = 'email';
  static const tglLahir   = 'tglLahir';
  static const jnsKelamin = 'jnsKelamin';
  static const password   = 'password';
  static const fotoProfil = 'fotoProfil';


  //tbl to do list
  static const judul      = 'judul';
  static const deskripsi  = 'deskripsi';
  static const remindTime = 'remindTime';
  static const intrvTime  = 'intrvTime';
  static const lampiran   = 'lampiran';


  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $namaDepan TEXT NOT NULL,
            $namaBlkng TEXT NOT NULL,
            $email TEXT NOT NULL,
            $tglLahir TEXT NOT NULL,
            $jnsKelamin TEXT NOT NULL,
            $password TEXT NOT NULL,
            $fotoProfil BLOB
          )
          ''');
    _onCreateTblList(db, version);
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row,{required String table}) async {
    return await _db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows({required String table}) async {
    return await _db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount({required String table}) async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<List<Map<String, dynamic>>> queryLogin({required String email, required String password}) async {
    String queryLogin = "SELECT  * FROM $table WHERE email='$email' AND password='$password'";

    final results = await _db.rawQuery(queryLogin);
    return results;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row,{required String table}) async {
    int id = row[columnId];
    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id,{required String table}) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }


  /*
  *
  * To Do List Table
  * */
  Future _onCreateTblList(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableList (
            $columnId INTEGER PRIMARY KEY,
            $judul TEXT NOT NULL,
            $deskripsi TEXT NOT NULL,
            $remindTime TEXT,
            $intrvTime TEXT,
            $lampiran TEXT NOT NULL
          )
          ''');
  }


}