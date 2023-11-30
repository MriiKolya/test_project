import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testproject/features/constant/constants.dart';
import 'package:testproject/features/data/sqlite/service/sqlite_database_service.dart';
import 'package:testproject/features/models/house_model.dart';
import 'package:testproject/features/models/submit_model.dart';

class SqliteDb {
  // Method to create the SQLite database table
  Future<void> createTable(Database database) async {
    await database.execute('''create table if not exists $tablename(
    id integer not null,
    name text not null,
    floor integer not null,
    vacantApartments JSON DEFAULT '[]' not null,
    primary key(id autoincrement)
    );''');
  }

  // Method to retrieve a list of HouseModel from the database
  Future<List<HouseModel>> getHouseList() async {
    final database = await SqliteDataBaseServices().dataBase;
    final list = await database.rawQuery('select * from $tablename');
    return list.map((house) => HouseModel.fromSqflite(house)).toList();
  }

  // Method to update the vacant status of an apartment in a house
  Future<void> moveToApart(HouseModel house, int index) async {
    try {
      // Generate a list of vacant status for each apartment
      List<bool> vacantApartments =
          List.generate(house.floor, (index) => false);
      vacantApartments[index] = true;

      // Get the database instance
      final database = await SqliteDataBaseServices().dataBase;

      // Serialize the list of vacant status to JSON
      String serializedApartments = jsonEncode(vacantApartments);

      // Update the vacant status in the database
      await database.rawUpdate(
        'UPDATE $tablename SET vacantApartments = ? WHERE id = ?',
        [serializedApartments, house.id],
      );
    } catch (e) {
      // Handle any errors that occur during the operation
      debugPrint(e.toString());
    }
  }

  // Method to add a new house to the database
  Future<void> addHouse(SubmitHouse house) async {
    // Get the database instance
    final database = await SqliteDataBaseServices().dataBase;

    // Generate a list of vacant status for each apartment
    List<bool> vacantApartments =
        List.generate(house.floor, (index) => index == 0);

    // Serialize the list of vacant status to JSON
    String serializedApartments = jsonEncode(vacantApartments);

    // Insert the new house into the database
    await database.rawInsert(
      'INSERT INTO $tablename (name, floor, vacantApartments) VALUES (?, ?, ?)',
      [
        house.name,
        house.floor,
        serializedApartments,
      ],
    );
  }

  // Method to delete all houses from the database
  Future<void> deleteList() async {
    final database = await SqliteDataBaseServices().dataBase;
    await database.rawDelete('DELETE FROM $tablename');
  }

  // Method to recreate the database table
  Future<void> recreateTable() async {
    final database = await SqliteDataBaseServices().dataBase;
    await database.execute('''DROP TABLE IF EXISTS $tablename;''');
    await createTable(database);
  }
}
