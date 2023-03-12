import 'package:asbeza/bloc/bloc/asbeza_bloc.dart';
import 'package:asbeza/presentation/screens/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/cart.dart';
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
  late List<CartData> catData;
  double totalAmount = 0;
  void calculateTotalAmount(List<Item> list) {
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
        if (state is ItemAddedCartState) {
          cartItems = state.items!;
          calculateTotalAmount(cartItems);
        }
        if (state is ItemPageLoadedState) {
          cartItems = state.cartData!.items;
          calculateTotalAmount(cartItems);
        }
        if (state is ItemAddingCartState) {
          cartItems = state.cartData!.items;
          calculateTotalAmount(cartItems);
        }
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
          body: cartItems == null || cartItems.length == 0
              ? Center(child: Text('Your Cart is Empty'))
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final Item itemName = _item[index];
                    return CartItems(
                      image: itemName.image,
                      foodTitle: itemName.name,
                      foodPrice: itemName.price,
                      cartButtonPressed: true,
                    );
                  },
                ),
        );
      },
    );
  }
}
