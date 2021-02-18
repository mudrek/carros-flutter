import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/db_helper.dart';
import 'package:carros/pages/favoritos/entity.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
abstract class BaseDAO<T extends Entity> {

  Future<Database> get db => DatabaseHelper.getInstance().db;

  String get entityName;

  T fromMap(Map<String, dynamic> map);

  Future<int> save(T entity) async {
    var dbClient = await db;
    var id = await dbClient.insert(entityName, entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<T>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from $entityName');

    return list.map<T>((json) => fromMap(json)).toList();
  }

  Future<T> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient.rawQuery('select * from $entityName where id = ?', [id]);

    if (list.length > 0) {
      return fromMap(list.first);
    }

    return null;
  }

  Future<bool> exists(int id) async {
    T t = await findById(id);
    var exists = t != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from $entityName');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $entityName where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $entityName');
  }
}
