import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

//     final product = productFromJson(jsonString);
class Item extends StatefulWidget {
  int? id;
  String name;
  double price;
  String image;
  int quantity = 1;

  Item({
    this.id,
    // this.quantity,
    required this.name,
    required this.price,
    required this.image,
  });

  void setQuantity(int quan) {
    this.quantity = quantity;
  }

  int getQuantity() {
    return this.quantity;
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      name: json["title"],
      price: json["price"]?.toDouble(),
      image: json["image"],
    );
  }
  static List itemList(List item) {
    List items = [];
    for (var i in item) {
      items.add(Item.fromJson(item[i]));
    }
    return items;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
