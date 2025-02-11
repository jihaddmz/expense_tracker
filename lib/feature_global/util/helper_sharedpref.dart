import 'package:expense_tracker/feature_global/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperSharedPref {
  static late SharedPreferences instance;

  static Future<void> setInstance() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<void> setDolarRate(int rate) async {
    await instance.setInt("dolar_rate", rate);
  }

  static Future<int> getDolarRate() async {
    return instance.getInt("dolar_rate") ?? 0;
  }

  static Future<void> setCategoriesBudget() async {
    for (var entry in Constants.categories.entries) {
      await instance.setDouble(entry.key, 70);
    }
  }

  static Future<void> setCategoryBudget(String category, double budget) async {
    await instance.setDouble(category, budget);
  }

  static double getCategoryBudget(String category) {
    return instance.getDouble(category) ?? 70;
  }
}
