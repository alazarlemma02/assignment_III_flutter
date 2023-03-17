import 'package:asbeza/bloc/bloc/item_bloc.dart';
import 'package:asbeza/presentation/screens/bottom_navigation_bar.dart';
import 'package:asbeza/presentation/screens/history_page.dart';
import 'package:asbeza/presentation/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asbeza/presentation/screens/item_list.dart';
import 'drawer_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  // late CartData carData;

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
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 2.0, 10.0, 5.0),
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
        ],
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
            child: BlocConsumer<ItemBloc, ItemState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return BlocListener<ItemBloc, ItemState>(
                  listener: (context, state) {
                    BlocProvider.of<ItemBloc>(context).cartData.length;
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Text(
                              '${BlocProvider.of<ItemBloc>(context).cartData.length.toString()}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                        // Text(carData!.totalItemsInCart()),
                      ]),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarScreen(),
      drawer: Drawer(
        child: DrawerPage(),
      ),
    );
  }
}
