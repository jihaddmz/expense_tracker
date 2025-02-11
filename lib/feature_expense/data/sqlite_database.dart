import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase {
  static late Database instance;

  static Future<void> createDatabase() async {
    instance = await openDatabase(
            // Set the path to the database. Note: Using the `join` function from the
            // `path` package is best practice to ensure the path is correctly
            // constructed for each platform.
            join(await getDatabasesPath(), 'db_app.db'),
            onCreate: (db, version) async {
      await db.execute(
          "create table tbl_months (date text primary key, savings double default 0)");
      await db.execute(
          "create table tbl_categories (category text, date text, budget double, paid double)");
    }, onUpgrade: (db, oldVersion, newVersion) {
      // db.execute("alter table tbl_months add column savings double default 0");
    }, version: 1)
        .catchError((error) {});
  }
}
