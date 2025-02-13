import 'package:expense_tracker/core/data/local/daos/dao_expense.dart';
import 'package:expense_tracker/core/data/local/datasource/database.dart';
import 'package:expense_tracker/feature_expense/domain/repository/repo_expense.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initializeDepdendencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerSingleton<AppDatabase>(database);
  getIt.registerSingleton<DaoExpense>(database.daoExpense);

  getIt.registerSingleton(RepositoryExpense(getIt()));
}
