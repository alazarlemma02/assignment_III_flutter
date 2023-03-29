import 'dart:async';
import 'package:asbeza/database/database.dart';
import 'package:asbeza/data/model/item.dart';

class CartDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Item records
  Future<Item> createItem(Item item) async {
    var db = await dbProvider.database;
    await db!.insert(cartTable, item.toDatabaseJson());
    return item;
  }

  //Get All Item items
  //Searches if query string was passed
  Future<List<Item>> getItems() async {
    var db = await dbProvider.database;

    final List<Map<String, Object?>> result = await db!.query(cartTable);
    return result.map((e) => Item.fromJson(e)).toList();
  }
  // // else {
  // //   result = await db.query(cartTable, columns: columns);
  // // }

  // List<Item> items = result!.isNotEmpty
  //     ? result.map((item) => Item.fromJson(item)).toList()
  //     : [];
  // return items;
  // }

  //Update Item record
  Future<int> updateItem(Item item) async {
    var db = await dbProvider.database;

    return await db!.update(cartTable, item.toDatabaseJson(),
        where: "id = ?", whereArgs: [item.id]);
  }

  //Delete Item records
  Future<int> deleteItem(int id) async {
    var db = await dbProvider.database;
    return await db!.delete(cartTable, where: 'id = ?', whereArgs: [id]);
  }

  //We are not going to use this in the demo
  Future deleteAllItems() async {
    var db = await dbProvider.database;
    return await db!.delete(
      cartTable,
    );
  }
}
