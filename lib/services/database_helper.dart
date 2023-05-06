import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:pbm/model/trans_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase("pbm.db");
    return _database!;
  }

  Future<Database> initDatabase(String dbName) async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, dbName);

    // Open the database
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create tables
        await db.execute('''
          CREATE TABLE userTransaction (
          id INTEGER PRIMARY KEY AUTOINCREMENT ,
            user_id TEXT ,
            amount INTEGER ,
            source TEXT ,
            type TEXT ,
            date TEXT 
            
          )  
        ''');
      },
    );
  }

  // // Close the database
  // Future<void> closeDatabase() async {
  //   final db = await database;
  //   db.close();
  // }


  // Insert a transaction into the database
  Future<void> insertTransaction(TransModel transModel) async {
    final db = await database;
    await db.insert('userTransaction', transModel.toMap());
  }

  // Retrieve all persons from the database
  Future<List<TransModel>> getAllTransactions() async {
    final currentUser = FirebaseAuth.instance.currentUser!.email;
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM userTransaction WHERE user_id=?',[currentUser]);
    return List.generate(maps.length, (i) {
      return TransModel.fromMap(maps[i]);
    });
  }

  // Update a person in the database
  // Future<void> updatePerson(Person person) async {
  //   final db = await database;
  //   await db.update(
  //     'my_table',
  //     person.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [person.id],
  //   );
  // }

  // Delete a person from the database
  Future<void> deleteTransaction(int id) async {
    final db = await database;
    await db.delete(
      'userTransaction',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
