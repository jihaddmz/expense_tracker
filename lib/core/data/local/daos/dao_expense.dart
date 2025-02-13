import 'dart:ffi';

import 'package:expense_tracker/core/data/local/entities/entity_paid.dart';
import 'package:expense_tracker/core/data/local/entities/entity_category.dart';
import 'package:expense_tracker/core/data/local/entities/entity_month.dart';
import 'package:floor/floor.dart';

@dao
abstract class DaoExpense {
  @insert
  Future<void> insertMonth(EntityMonth month);

  @Query('SELECT * FROM EntityMonth')
  Future<List<EntityMonth>> getAllMonths();

  @Query('SELECT * FROM EntityMonth WHERE date = :date')
  Future<EntityMonth?> getMonthByDate(String date);

  @Query('SELECT * FROM EntityCategory WHERE date = :date')
  Future<List<EntityCategory>> getAllCategories(String date);

  @insert
  Future<void> insertCategory(EntityCategory category);

  @update
  Future<void> updateCategory(EntityCategory category);

  @Query(
      'Select * from EntityCategory where date = :date and category = :category')
  Future<EntityCategory?> getCategoryByDate(String date, String category);

  @insert
  Future<void> insertPaid(EntityPaid paid);

  @Query('SELECT * FROM EntityPaid WHERE month = :month')
  Future<List<EntityPaid>> getAllPaidByMonth(String month);

  @Query('SELECT * FROM EntityPaid WHERE month = :month AND day = :day')
  Future<List<EntityPaid>> getAllPaidByMonthAndDay(String month, int day);

  @Query('SELECT paid FROM EntityPaid WHERE month = :month')
  Future<List<double>> getAllPaidsByMonth(String month);

  @Query('SELECT paid FROM EntityPaid WHERE month = :month and day = :day')
  Future<List<double>> getAllPaidsByMonthAndDay(String month, int day);
}
