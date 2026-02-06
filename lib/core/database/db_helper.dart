import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_sales.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Table Utilisateur
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        isDarkMode INTEGER NOT NULL
      )
    ''');

    // Table Produits (Mock data pour la RDC)
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL
      )
    ''');

    // Table Ventes
    await db.execute('''
      CREATE TABLE sales (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productName TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        isSynced INTEGER NOT NULL,
        paymentMethod TEXT NOT NULL
      )
    ''');

    // Insertion optionnelle des produits par défaut
    await _seedProducts(db);
  }

  Future<void> _seedProducts(Database db) async {
    List<Map<String, dynamic>> products = [
      {'name': 'iPhone 15 Pro Max', 'price': 3500000.0},
      {'name': 'Samsung Galaxy S24', 'price': 3200000.0},
      {'name': 'Tecno Camon 30', 'price': 850000.0},
    ];
    for (var p in products) {
      await db.insert('products', p);
    }
  }

  // --- OPÉRATIONS CRUD POUR LES VENTES ---

  Future<int> insertSale(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('sales', row);
  }

  Future<List<Map<String, dynamic>>> getAllSales() async {
    final db = await instance.database;
    return await db.query('sales', orderBy: 'date DESC');
  }

  Future<int> deleteSale(int id) async {
    final db = await instance.database;
    return await db.delete('sales', where: 'id = ?', whereArgs: [id]);
  }

  // --- OPÉRATIONS CRUD POUR L'UTILISATEUR ---

  // 1. Sauvegarder ou mettre à jour l'utilisateur unique (ID = 1)
  Future<int> saveUser(Map<String, dynamic> userData) async {
    final db = await instance.database;

    // conflictAlgorithm: ConflictAlgorithm.replace est crucial ici :
    // Si l'utilisateur avec l'ID 1 existe déjà, il sera mis à jour.
    // Sinon, il sera créé.
    return await db.insert(
      'users',
      userData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 2. Récupérer les données de l'utilisateur
  Future<Map<String, dynamic>?> getUser() async {
    final db = await instance.database;

    // On récupère le premier utilisateur trouvé (généralement le seul)
    final List<Map<String, dynamic>> maps = await db.query('users', limit: 1);

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // 3. Supprimer l'utilisateur/Déconnexion
  Future<int> deleteUser() async {
    final db = await instance.database;
    return await db.delete('users');
  }
}
