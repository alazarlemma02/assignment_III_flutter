import 'package:asbeza/bloc/bloc/item_bloc.dart';
import 'package:asbeza/presentation/screens/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        if (state is ItemLoadingState) {
          return const Center(
            child: Text('Your Cart is Empty'),
          );
        }
        if (state is ItemLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ItemLoadedState) {
          cartItems = state.cartData;
          calculateTotalAmount(state.cartData);
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text('Total Amount'),
                      Text('\$${totalAmount.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const BottomNavigationBarScreen(),
            body: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final Item itemName = state.cartData[index];
                final Item itemAdded = Item(
                    name: itemName.name,
                    price: itemName.price,
                    image: itemName.image);
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
                                  image: NetworkImage(itemAdded.image),
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
                                    child: Text(itemAdded.name.toString()),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      '\$${itemAdded.price.toString()}',
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
            ),
          );
        }
        return Container();
      },
    );
  }
}
