import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int selectedIndex = 0;
  void _onTapedItem(int index) {
    if (index == 0) {
      setState(() {
        selectedIndex = 0;
      });
      Navigator.pushNamed(context, '/');
    } else if (index == 1) {
      setState(() {
        selectedIndex = 1;
      });
      Navigator.pushNamed(context, '/history');
    }

    // return selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      selectedFontSize: 20,
      iconSize: 30,
      showUnselectedLabels: false,
      backgroundColor: Colors.green,
      onTap: _onTapedItem,
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, color: Colors.white),
          label: 'Favorite',
        ),
      ],
    );
  }
}
