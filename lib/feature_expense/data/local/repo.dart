import 'package:expense_tracker/feature_expense/data/local/sqlite_database.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_category.dart';
import 'package:expense_tracker/feature_expense/domain/model/model_month.dart';
import 'package:sqflite/sqflite.dart';

class RepositoryExpense {

  static Future<void> insertMonth(ModelMonth modelMonth) async {
    await SqliteDatabase.instance.insert("tbl_months", modelMonth.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<ModelMonth>> getAllMonths() async {
    final List<Map<String, dynamic>> listOfRecords =
        await SqliteDatabase.instance.query("tbl_months");
    return List.generate(listOfRecords.length, (index) {
      return ModelMonth(
          date: listOfRecords[index]['date'],
          savings: listOfRecords[index]['savings']);
    });
  }

  static Future<ModelMonth?> getModelMonthByDate(String date) async {
    final result = await SqliteDatabase.instance
        .rawQuery('select * from tbl_months where date=?', [date]);

    if (result.isEmpty) {
      return null;
    } else {
      return ModelMonth(date: result.first['date'] as String);
    }
  }

  static Future<List<ModelCategory>> getAllCategories(String date) async {
    final List<Map<String, dynamic>> listOfRecords = await SqliteDatabase.instance
        .rawQuery("select * from tbl_categories where date = ?", [date]);
    return List.generate(listOfRecords.length, (index) {
      return ModelCategory(
        category: listOfRecords[index]['category'],
        date: listOfRecords[index]['date'],
        budget: listOfRecords[index]['budget'],
        paid: listOfRecords[index]['paid'],
      );
    });
  }

  static Future<void> insertCategory(ModelCategory modelCategory) async {
    await SqliteDatabase.instance.insert("tbl_categories", modelCategory.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> updateCategoryPaid(
      ModelCategory modelCategory, double paid) async {
    await SqliteDatabase.instance.rawUpdate(
        "update tbl_categories set paid = ? where category = ? and date = ?",
        [paid, modelCategory.category, modelCategory.date]);
  }

  static Future<ModelCategory?> getCategoryByDateAndCategory(
      String date, String category) async {
    final result = await SqliteDatabase.instance.rawQuery(
        'select * from tbl_categories where date=? and category=?',
        [date, category]);

    if (result.isEmpty) {
      return null;
    } else {
      return ModelCategory(
          date: result.first['date'] as String,
          category: result.first['category'] as String,
          budget: result.first['budget'] as double,
          paid: result.first['paid'] as double);
    }
  }

  static Future<void> updateCategoryBudget(
      ModelCategory modelCategory, double budget) async {
    await SqliteDatabase.instance.rawUpdate(
        "update tbl_categories set budget = ? where category = ? and date = ?",
        [budget, modelCategory.category, modelCategory.date]);
  }
}