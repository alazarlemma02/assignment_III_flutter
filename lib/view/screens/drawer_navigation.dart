import 'package:asbeza/view/screens/history_page.dart';
import 'package:asbeza/view/screens/home_page.dart';
import 'package:asbeza/view/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/item_bloc.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.green),
          child: CircleAvatar(
            radius: 5,
            backgroundColor: Colors.black,
            child: Icon(
              Icons.person,
              size: 80,
              color: Colors.green,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: const Text('Home'),
          iconColor: Colors.green,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<ItemBloc>(context),
                    child: const HomePage()),
              ),
            );
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: const Text('Cart'),
          iconColor: Colors.green,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<ItemBloc>(context),
                    child: const HistoryPage()),
              ),
            );
            // Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: const Text('Profile'),
          iconColor: Colors.green,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<ItemBloc>(context),
                    child: const ProfilePage()),
              ),
            );
            // Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
