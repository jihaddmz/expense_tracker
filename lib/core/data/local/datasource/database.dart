import 'package:expense_tracker/core/data/local/daos/dao_expense.dart';
import 'package:expense_tracker/core/data/local/entities/entity_paid.dart';
import 'package:expense_tracker/core/data/local/entities/entity_category.dart';
import 'package:expense_tracker/core/data/local/entities/entity_month.dart';

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [EntityMonth, EntityCategory, EntityPaid])
abstract class AppDatabase extends FloorDatabase {
  DaoExpense get daoExpense;
}