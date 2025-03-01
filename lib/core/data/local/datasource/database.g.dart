// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DaoExpense? _daoExpenseInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EntityMonth` (`date` TEXT NOT NULL, `savings` REAL NOT NULL, PRIMARY KEY (`date`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EntityCategory` (`category` TEXT NOT NULL, `date` TEXT NOT NULL, `budget` REAL NOT NULL, `paid` REAL NOT NULL, PRIMARY KEY (`category`, `date`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EntityPaid` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `day` INTEGER NOT NULL, `paid` REAL NOT NULL, `month` TEXT NOT NULL, `category` TEXT NOT NULL, `date` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DaoExpense get daoExpense {
    return _daoExpenseInstance ??= _$DaoExpense(database, changeListener);
  }
}

class _$DaoExpense extends DaoExpense {
  _$DaoExpense(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _entityMonthInsertionAdapter = InsertionAdapter(
            database,
            'EntityMonth',
            (EntityMonth item) =>
                <String, Object?>{'date': item.date, 'savings': item.savings}),
        _entityCategoryInsertionAdapter = InsertionAdapter(
            database,
            'EntityCategory',
            (EntityCategory item) => <String, Object?>{
                  'category': item.category,
                  'date': item.date,
                  'budget': item.budget,
                  'paid': item.paid
                }),
        _entityPaidInsertionAdapter = InsertionAdapter(
            database,
            'EntityPaid',
            (EntityPaid item) => <String, Object?>{
                  'id': item.id,
                  'day': item.day,
                  'paid': item.paid,
                  'month': item.month,
                  'category': item.category,
                  'date': item.date
                }),
        _entityCategoryUpdateAdapter = UpdateAdapter(
            database,
            'EntityCategory',
            ['category', 'date'],
            (EntityCategory item) => <String, Object?>{
                  'category': item.category,
                  'date': item.date,
                  'budget': item.budget,
                  'paid': item.paid
                }),
        _entityMonthDeletionAdapter = DeletionAdapter(
            database,
            'EntityMonth',
            ['date'],
            (EntityMonth item) =>
                <String, Object?>{'date': item.date, 'savings': item.savings});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EntityMonth> _entityMonthInsertionAdapter;

  final InsertionAdapter<EntityCategory> _entityCategoryInsertionAdapter;

  final InsertionAdapter<EntityPaid> _entityPaidInsertionAdapter;

  final UpdateAdapter<EntityCategory> _entityCategoryUpdateAdapter;

  final DeletionAdapter<EntityMonth> _entityMonthDeletionAdapter;

  @override
  Future<List<EntityMonth>> getAllMonths() async {
    return _queryAdapter.queryList('SELECT * FROM EntityMonth',
        mapper: (Map<String, Object?> row) => EntityMonth(
            date: row['date'] as String, savings: row['savings'] as double));
  }

  @override
  Future<EntityMonth?> getMonthByDate(String date) async {
    return _queryAdapter.query('SELECT * FROM EntityMonth WHERE date = ?1',
        mapper: (Map<String, Object?> row) => EntityMonth(
            date: row['date'] as String, savings: row['savings'] as double),
        arguments: [date]);
  }

  @override
  Future<List<EntityCategory>> getAllCategories(String date) async {
    return _queryAdapter.queryList(
        'SELECT * FROM EntityCategory WHERE date = ?1',
        mapper: (Map<String, Object?> row) => EntityCategory(
            category: row['category'] as String,
            date: row['date'] as String,
            budget: row['budget'] as double,
            paid: row['paid'] as double),
        arguments: [date]);
  }

  @override
  Future<EntityCategory?> getCategoryByDate(
    String date,
    String category,
  ) async {
    return _queryAdapter.query(
        'Select * from EntityCategory where date = ?1 and category = ?2',
        mapper: (Map<String, Object?> row) => EntityCategory(
            category: row['category'] as String,
            date: row['date'] as String,
            budget: row['budget'] as double,
            paid: row['paid'] as double),
        arguments: [date, category]);
  }

  @override
  Future<List<EntityPaid>> getAllPaidByMonth(String month) async {
    return _queryAdapter.queryList('SELECT * FROM EntityPaid WHERE month = ?1',
        mapper: (Map<String, Object?> row) => EntityPaid(
            id: row['id'] as int?,
            day: row['day'] as int,
            paid: row['paid'] as double,
            month: row['month'] as String,
            category: row['category'] as String,
            date: row['date'] as String),
        arguments: [month]);
  }

  @override
  Future<List<EntityPaid>> getAllPaidByMonthAndDay(
    String month,
    int day,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM EntityPaid WHERE month = ?1 AND day = ?2',
        mapper: (Map<String, Object?> row) => EntityPaid(
            id: row['id'] as int?,
            day: row['day'] as int,
            paid: row['paid'] as double,
            month: row['month'] as String,
            category: row['category'] as String,
            date: row['date'] as String),
        arguments: [month, day]);
  }

  @override
  Future<List<double>> getAllPaidsByMonth(String month) async {
    return _queryAdapter.queryList(
        'SELECT paid FROM EntityPaid WHERE month = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [month]);
  }

  @override
  Future<List<double>> getAllPaidsByMonthAndDay(
    String month,
    int day,
  ) async {
    return _queryAdapter.queryList(
        'SELECT paid FROM EntityPaid WHERE month = ?1 and day = ?2',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [month, day]);
  }

  @override
  Future<void> insertMonth(EntityMonth month) async {
    await _entityMonthInsertionAdapter.insert(month, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertCategory(EntityCategory category) async {
    await _entityCategoryInsertionAdapter.insert(
        category, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertPaid(EntityPaid paid) async {
    await _entityPaidInsertionAdapter.insert(paid, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCategory(EntityCategory category) async {
    await _entityCategoryUpdateAdapter.update(
        category, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMonth(EntityMonth month) async {
    await _entityMonthDeletionAdapter.delete(month);
  }
}
