import 'dart:convert';

List<Item> itemFromJson(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

//     final product = productFromJson(jsonString);
class Item {
  int? id;
  String name;
  double price;
  String image;
  int quantity = 1;

  Item({
    this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      name: json["title"],
      price: json["price"]?.toDouble(),
      image: json["image"],
    );
  }
}
