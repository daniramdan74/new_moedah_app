// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
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
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartDao _cartDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `Cart` (`id` INTEGER, `uid` TEXT, `name` TEXT, `description` TEXT, `category` TEXT, `price` TEXT, `qty` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _cartInsertionAdapter = InsertionAdapter(
            database,
            'Cart',
            (Cart item) => <String, dynamic>{
                  'id': item.id,
                  'uid': item.uid,
                  'name': item.name,
                  'description': item.description,
                  'category': item.category,
                  'price': item.price,
                  'qty': item.qty
                },
            changeListener),
        _cartUpdateAdapter = UpdateAdapter(
            database,
            'Cart',
            ['id'],
            (Cart item) => <String, dynamic>{
                  'id': item.id,
                  'uid': item.uid,
                  'name': item.name,
                  'description': item.description,
                  'category': item.category,
                  'price': item.price,
                  'qty': item.qty
                },
            changeListener),
        _cartDeletionAdapter = DeletionAdapter(
            database,
            'Cart',
            ['id'],
            (Cart item) => <String, dynamic>{
                  'id': item.id,
                  'uid': item.uid,
                  'name': item.name,
                  'description': item.description,
                  'category': item.category,
                  'price': item.price,
                  'qty': item.qty
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _cartMapper = (Map<String, dynamic> row) => Cart(
      id: row['id'] as int,
      uid: row['uid'] as String,
      name: row['name'] as String,
      description: row['description'] as String,
      category: row['category'] as String,
      price: row['price'] as String,
      qty: row['qty'] as int);

  final InsertionAdapter<Cart> _cartInsertionAdapter;

  final UpdateAdapter<Cart> _cartUpdateAdapter;

  final DeletionAdapter<Cart> _cartDeletionAdapter;

  @override
  Stream<List<Cart>> getAllItemInCartByUid(String uid) {
    return _queryAdapter.queryListStream('SELECT * FROM Cart WHERE uid=?',
        arguments: <dynamic>[uid],
        queryableName: 'Cart',
        isView: false,
        mapper: _cartMapper);
  }

  @override
  Future<Cart> getItemInCartByUid(String uid, int id) async {
    return _queryAdapter.query('SELECT * FROM Cart WHERE uid=? AND id=?',
        arguments: <dynamic>[uid, id], mapper: _cartMapper);
  }

  @override
  Stream<List<Cart>> clearCartByUid(String uid) {
    return _queryAdapter.queryListStream('DELETE * FROM Cart WHERE uid=?',
        arguments: <dynamic>[uid],
        queryableName: 'Cart',
        isView: false,
        mapper: _cartMapper);
  }

  @override
  Future<Cart> deleteAllCart() async {
    return _queryAdapter.query('DELETE FROM Cart', mapper: _cartMapper);
  }

  @override
  Future<void> insertCart(Cart product) async {
    await _cartInsertionAdapter.insert(product, OnConflictStrategy.abort);
  }

  @override
  Future<int> updatetCart(Cart product) {
    return _cartUpdateAdapter.updateAndReturnChangedRows(
        product, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteCart(Cart product) {
    return _cartDeletionAdapter.deleteAndReturnChangedRows(product);
  }
}
