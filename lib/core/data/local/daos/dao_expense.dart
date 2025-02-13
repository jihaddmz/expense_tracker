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

  @Query('Select * from EntityCategory where date = :date and category = :category')
  Future<EntityCategory?> getCategoryByDate(String date, String category);
  
}
