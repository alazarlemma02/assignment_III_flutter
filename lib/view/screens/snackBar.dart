import 'package:flutter/material.dart';

class ShowSnackBartMessage extends StatelessWidget {
  const ShowSnackBartMessage({super.key});
  @override
  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
        duration: Duration(seconds: 03),
        backgroundColor: Colors.white,
        content: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Item Added to cart!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green),
          ),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
