// import 'package:confirmation_dialog/confirmation_dialog.dart';
import 'package:asbeza/bloc/bloc/item_bloc.dart';

import 'package:asbeza/view/screens/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:asbeza/data/model/item.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_permission/request_permission.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List? _item;
  // List<CartData>? cartItems;
  int quantity = 1;
  // List<CartData> _cart = [];
  // List<Item> addedItems = [];

  // final Item item;
  RequestPermission requestPermission = RequestPermission.instace;

  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().cartPageProvider.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemInitial) {
            Center(
                child: Container(
              child: Text(
                'Welcome',
                style: TextStyle(color: Colors.green),
              ),
            ));
            BlocProvider.of<ItemBloc>(context)..add(ItemAddingCartEvent());
          }
          if (state is ItemLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else if (state is ItemLoadedState) {
            return ListView.builder(
              itemCount: state.item.length,
              itemBuilder: (context, index) {
                final ItemBloc itemBloc = ItemBloc();
                final Item itemName = state.item[index];
                final cartItem = state.item[index];
                // int quantity = itemName.getQuantity();
                return Container(
                  height: 200.0,
                  child: Card(
                    shadowColor: Colors.green,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(padding: EdgeInsets.all(5.0)),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                padding: EdgeInsets.only(top: 10.0),
                                width: 100.0,
                                child: Image(
                                  image: NetworkImage(state.item[index].image),
                                  height: 95.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5.0),
                                    width: 200,
                                    child: Text(itemName.name.length > 50
                                        ? '\$${itemName.name.substring(0, 50)}'
                                        : itemName.name.toString()),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      '\$${state.item[index].price.toString()}',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 210, 7)),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Container(
                                  height: 15,
                                  width: 50,
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    color: Colors.green,
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5.0),
                                  height: 30,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(quantity.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: 50,
                                  child: IconButton(
                                    icon: Icon(Icons.remove),
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        quantity--;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // const ConfirmToCart(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Image(
                                                  image: NetworkImage(
                                                      state.item[index].image),
                                                  height: 100,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '\$${(state.item[index].price * quantity).toString()}',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 210, 7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 30.0, top: 30.0),
                                              child: Text(
                                                quantity.toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                if (quantity <= 0) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        AlertDialog(actions: [
                                                      Text(
                                                        'Can\'t add \'0\' Quantity!!',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ]),
                                                  );
                                                } else {
                                                  final cart =
                                                      BlocProvider.of<ItemBloc>(
                                                          context,
                                                          listen: false);
                                                  final cartProvider =
                                                      ItemBloc();
                                                  void saveData(int index) {
                                                    cartProvider
                                                        .cartPageProvider
                                                        .cartDao
                                                        .createItem(
                                                      Item(
                                                        id: index,
                                                        name: itemName.name,
                                                        price: itemName.price,
                                                        quantity:
                                                            ValueNotifier(1),
                                                        image: itemName.image,
                                                        is_added: true,
                                                      ),
                                                    )
                                                        .then((value) {
                                                      cart.cartPageProvider
                                                          .addTotalPrice(
                                                              itemName.price
                                                                  .toDouble());
                                                      cart.cartPageProvider
                                                          .addCounter();
                                                      print(
                                                          'Product Added to cart');
                                                    }).onError((error,
                                                            stackTrace) {
                                                      print(error.toString());
                                                    });
                                                  }

                                                  saveData(index);
                                                  print(cartProvider.cartData
                                                      .indexOf(itemName));
                                                  BlocProvider.of<ItemBloc>(
                                                          context)
                                                      .add(ItemAddedCartEvent(
                                                          items: cartItem));
                                                  ShowSnackBartMessage
                                                      snackBartMessage =
                                                      ShowSnackBartMessage();
                                                  snackBartMessage
                                                      .showSnackBar(context);

                                                  Navigator.pop(context);
                                                }
                                                ;
                                              },
                                              child: Text(
                                                'Add',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              ))
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // <-- Radius
                                    ),
                                  ),
                                ),
                              ),
                            ])
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
