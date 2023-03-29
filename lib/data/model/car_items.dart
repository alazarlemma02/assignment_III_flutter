// List addedItems = [];
// double totalPrice = 0;

class ProductCartEntity {
  final int id;
  final String name;
  final String image;
  final double price;

  ProductCartEntity(
      {required this.id,
      required this.name,
      required this.image,
      required this.price});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }

  @override
  List<Object> get props => [id, name, image, price];
}
