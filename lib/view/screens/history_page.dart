import 'package:asbeza/bloc/bloc/item_bloc.dart';
import 'package:asbeza/dao/cart_dao.dart';
import 'package:asbeza/data/model/repository/cart_provider.dart';
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
  CartDao cartPageProvider = CartDao();
  int _selectedIndex = 0;
  List<Item> _item = [];
  void _onItemTapped(String route) {
    Navigator.pushNamed(context, route);
  }

  late List<Item> cartItems = [];
  // late List<CartData> catData;
  double totalAmount = 0;
  void calculateTotalAmount(List list) {
    double res = 0;

    list.forEach((element) {
      res = res + element.price * element.quantity;
    });
    totalAmount = res;
  }

  @override
  Widget build(BuildContext context) {
    final cart = BlocProvider.of<ItemBloc>(context);
    return BlocBuilder<ItemBloc, ItemState?>(
      builder: (context, state) {
        if (state is ItemLoadingState) {
          return Scaffold(
            body: SafeArea(
              child: const Center(
                child: Text('Your Cart is Empty'),
              ),
            ),
            bottomNavigationBar: BottomNavigationBarScreen(),
          );
        }
        if (state is ItemLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ItemLoadedState) {
          cartItems = cart.cartData;
          // calculateTotalAmount(state.cartData);
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
                    for (var element in cartItems) {
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
                                    value: r'$' +
                                        (val?.toStringAsFixed(2) ?? '0'));
                              }),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
            bottomNavigationBar: const BottomNavigationBarScreen(),
            body: FutureBuilder<List>(
              future: cartPageProvider.getItems(),
              builder: ((context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: state.cartData.length,
                        itemBuilder: (BuildContext context, int index) {
                          final itemName = state.item[index];
                          int quantity = itemName.getQuantity();
                          final Item cartItem = Item(
                            name: itemName.name,
                            price: itemName.price,
                            image: itemName.image,
                            quantity: ValueNotifier(cart
                                .cartPageProvider.cart[index].quantity!.value),
                            is_added: true,
                          );
                          int cartAmount() {
                            return state.cartData.length;
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
                                            image: NetworkImage(cartItem.image),
                                            height: 95.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  EdgeInsets.only(top: 5.0),
                                              width: 200,
                                              child: Text(
                                                  cartItem.name.toString()),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              width: 200,
                                              child: Text(
                                                '\$${(itemName.price * quantity).toString()}',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 210, 7)),
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
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              }),
            ),
          );
        }
        return Container();
      },
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
