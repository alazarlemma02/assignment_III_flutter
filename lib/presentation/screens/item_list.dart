// import 'package:confirmation_dialog/confirmation_dialog.dart';
import 'package:asbeza/bloc/bloc/asbeza_bloc.dart';
import 'package:asbeza/data/model/cart.dart';
import 'package:asbeza/presentation/screens/history_page.dart';
import 'package:flutter/material.dart';
import 'package:asbeza/data/model/item.dart';
import 'package:asbeza/data/model/repository/apiServicesProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_permission/request_permission.dart';

import '../../bloc/bloc/cart_bloc.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Item> _item = [];
  List<CartData>? cartItems;
  int quantity = 1;
  // List<CartData> _cart = [];
  List<Item> addedItems = [];

  // final Item item;
  RequestPermission requestPermission = RequestPermission.instace;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _item = (await ApiServiceProvider().fetchItem())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemBloc, ItemState>(
      listener: (context, state) {
        if (state is ItemInitial) {
          Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (state is ItemPageLoadedState) {
          _item = state.item;
        }
      },
      child: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: _item.length,
            itemBuilder: (context, index) {
              final String itemName = _item[index].name;
              return Container(
                height: 180.0,
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
                                image: NetworkImage(_item[index].image),
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
                                  child: Text(itemName.length > 50
                                      ? '${itemName.substring(0, 50)}...'
                                      : itemName),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 200,
                                  child: Text(
                                    '\$${_item[index].price.toString()}',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 210, 7)),
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
                                    fontWeight: FontWeight.bold, fontSize: 15),
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
                                height: 20,
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
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                                                _item[index].image),
                                            height: 100,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '\$${(_item[index].price * quantity).toString()}',
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
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                value:
                                                    BlocProvider.of<ItemBloc>(
                                                        context),
                                                child: const HistoryPage(),
                                              ),
                                            ),
                                          );

                                          Item item = Item(
                                              image: _item[index].image,
                                              name: _item[index].name,
                                              price: _item[index].price);
                                          addedItems.add(item);

                                          BlocProvider.of<CartBloc>(context)
                                              .add(AddButtonPressed());

                                          // _cart.add(cartItems![index]);

                                          // print('${cartItems![index]}');

                                          // print('Added to the cart');
                                          // Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Add',
                                          style: TextStyle(color: Colors.green),
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
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
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
        },
      ),
    );
  }
}
