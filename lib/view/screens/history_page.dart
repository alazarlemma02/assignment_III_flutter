import 'package:asbeza/bloc/bloc/item_bloc.dart';
import 'package:asbeza/dao/cart_dao.dart';
import 'package:asbeza/data/model/car_items.dart';
import 'package:asbeza/data/model/repository/cart_provider.dart';
import 'package:asbeza/data/model/repository/cart_repositroy.dart';
import 'package:asbeza/database/database.dart';
import 'package:asbeza/view/screens/bottom_navigation_bar.dart';
import 'package:asbeza/view/widget/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/model/item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final ItemBloc itemBloc = ItemBloc();
  final DismissDirection _dismissDirection = DismissDirection.horizontal;
  DatabaseProvider? databaseProvider = DatabaseProvider();
  final cartPageProvider = CartDao();
  int _selectedIndex = 0;
  List<Map<String, dynamic>>? _cartItem;

  double totalAmount = 0;
  void calculateTotalAmount(List list) {
    double res = 0;

    list.forEach((element) {
      res = res + element.price * element.quantity;
    });
    totalAmount = res;
  }

  @override
  void initState() {
    final _cart = CartRepository();
    _cart.readItem().then((value) => _cartItem = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(left: 20),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              final ValueNotifier<int?> totalPrice = ValueNotifier(null);
              for (var element in itemBloc.cartData) {
                totalPrice.value =
                    ((element.price).toInt() * element.quantity!.value) +
                        (totalPrice.value ?? 0);
              }
              return Padding(
                padding: const EdgeInsets.only(right: 20.0, top: 10),
                child: Column(
                  children: [
                    ValueListenableBuilder<int?>(
                        valueListenable: totalPrice,
                        builder: (context, val, child) {
                          return ReusableWidget(
                              title: 'Total Price',
                              value: r'$' + (val?.toStringAsFixed(2) ?? '0'));
                        }),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is CartInitialState) {
            if (_cartItem == null) {
              return Scaffold(
                body: SafeArea(
                    child: Center(
                  child: Text("Your cart is empty"),
                )),
              );
            } else {
              for (var i = 0; i < _cartItem!.length; i++) {
                itemBloc.cartData.add(Item.fromJson(_cartItem![i]));
              }
            }
          } else if (state is CartLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          } else if (state is CartLoadedState) {
            return ListView.builder(
              itemCount: state.cartProducts.length,
              itemBuilder: (BuildContext context, int index) {
                final Item itemName = state.cartProducts[index];
                int quantity = state.cartProducts.length;
                final Item cartItem = Item(
                  name: itemName.name,
                  price: itemName.price,
                  image: itemName.image,
                  is_added: true,
                );
                int cartAmount() {
                  return state.cartProducts.length;
                }

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
                                  image: NetworkImage(itemName.image),
                                  height: 95.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5.0),
                                    width: 200,
                                    child: Text(itemName.name.toString()),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      '\$${(cartItem.price * quantity).toString()}',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 210, 7)),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // const ConfirmToCart(),
                        Row(),
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
      bottomNavigationBar: const BottomNavigationBarScreen(),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;

  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
