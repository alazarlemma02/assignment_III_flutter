import 'package:asbeza/bloc/bloc/asbeza_bloc.dart';
import 'package:asbeza/data/model/cart.dart';
import 'package:asbeza/presentation/screens/bottom_navigation_bar.dart';
import 'package:asbeza/presentation/screens/history_page.dart';
import 'package:asbeza/presentation/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:asbeza/data/model/item.dart';
import 'package:asbeza/data/model/repository/apiServicesProvider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_permission/request_permission.dart';
import 'package:asbeza/presentation/screens/item_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  late CartData carData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        title: const Text('Shop'),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 2.0, 0, 2.0),
          child: GestureDetector(
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<ItemBloc>(context),
                      child: const ProfilePage()),
                ),
              );
            }),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.person,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
      body: ItemList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              // Navigator.pushNamed(context, '/history');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<ItemBloc>(context),
                      child: const HistoryPage()),
                ),
              );
              print("to the history page");
            },
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              // Text(carData!.totalItemsInCart()),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(),
    );
  }
}
