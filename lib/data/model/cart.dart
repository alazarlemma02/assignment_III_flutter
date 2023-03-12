import 'package:asbeza/data/model/repository/car_items.dart';

import '../../bloc/bloc/cart_bloc.dart';
import 'item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartData {
  List<Item> items;
  List<Item> cartData = [];

  CartData({required this.items});

  void addProduct(Item item) {
    cartData.add(item);
  }

  String totalItemsInCart() {
    return items.length.toString();
  }
}

class CartItems extends StatelessWidget {
  final String image;
  final String foodTitle;
  final double foodPrice;
  final bool cartButtonPressed;

  const CartItems(
      {required this.image,
      required this.foodTitle,
      required this.foodPrice,
      required this.cartButtonPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    const String dollar_sign = "\$";
    int index_to_remove = 0;
    bool item_to_remove_found = false;
    double total_price = 0;
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          color: Color.fromARGB(255, 252, 250, 250),
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: 380,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(image)),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * .3,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                ),
                Container(
                  height: 50,
                  color: Colors.white10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Container(width: 200, child: Text(foodTitle))),
                      Text(dollar_sign + foodPrice.toString()),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (!cartButtonPressed) {
                      Item item =
                          Item(image: image, name: foodTitle, price: foodPrice);
                      addedItems.add(item);
                      calculatePrice();
                      BlocProvider.of<CartBloc>(context)
                          .add(AddButtonPressed());
                    } else {
                      Item item = Item(
                        image: image,
                        name: foodTitle,
                        price: foodPrice,
                      );
                      for (int i = 0;
                          i < addedItems.length &&
                              item_to_remove_found == false;
                          i++) {
                        if (item.name == addedItems[i].foodTitle) {
                          index_to_remove = i;
                          item_to_remove_found = true;
                        }
                      }
                      item_to_remove_found = false;
                      addedItems.removeAt(index_to_remove);
                      calculatePrice();
                    }
                  },
                  icon: cartButtonPressed
                      ? const Icon(Icons.remove_shopping_cart)
                      : const Icon(Icons.shopping_cart),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//calculate the total price
void calculatePrice() {
  totalPrice = 0;
  for (int i = 0; i < addedItems.length; i++) {
    totalPrice += addedItems[i].foodPrice;
    //fix the precision to 2 decimal numbers
    String stringTotalPrice = totalPrice.toStringAsFixed(2);
    //cast back to double
    totalPrice = double.parse(stringTotalPrice);
  }
}
