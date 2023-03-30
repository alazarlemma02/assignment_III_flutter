import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

//     final product = productFromJson(jsonString);
class Item {
  int? id;
  String name;
  double price;
  String image;
  ValueNotifier<int>? quantity;
  bool is_added = false;

  Item({
    this.id,
    this.is_added = false,
    this.quantity,
    required this.name,
    required this.price,
    required this.image,
  });

  void setQuantity(int quan) {
    this.quantity = quantity;
  }

  int getQuantity() {
    return quantity!.value;
  }

  factory Item.fromJson(Map<dynamic, dynamic> json) {
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
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Map<String, dynamic> toDatabaseJson() {
    return {
      //This will be used to convert Item objects that
      //are to be stored into the datbase in a form of JSON
      "id": id,
      "name": name,
      "price": price,
      "image": image,
      "status": is_added,
    };
  }

  Map toJson() {
    return {'name': name, 'price': price, 'image': image, 'status': is_added};
  }
}
