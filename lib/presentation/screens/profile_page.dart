import 'dart:async';

import 'package:asbeza/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_number/mobile_number.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';

import '../../bloc/bloc/asbeza_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;
  SimData? _simData;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    SimData simData;
    try {
      var status = await Permission.phone.status;
      if (!status.isGranted) {
        bool isGranted = await Permission.phone.request().isGranted;
        if (!isGranted) return;
      }
      simData = await SimDataPlugin.getSimData();
      setState(() {
        _isLoading = false;
        _simData = simData;
      });
      void printSimCardsData() async {
        try {
          SimData simData = await SimDataPlugin.getSimData();
          for (var s in simData.cards) {
            // ignore: avoid_print
            print('Serial number: ${s.serialNumber}');
          }
        } on PlatformException catch (e) {
          debugPrint("error! code: ${e.code} - message: ${e.message}");
        }
      }

      printSimCardsData();
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _isLoading = false;
        _simData = null;
      });
    }
  }

  getPhoneNumber() async {
    return (await MobileNumber.mobileNumber);
  }

  @override
  Widget build(BuildContext context) {
    var cards = _simData?.cards;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
              color: Colors.white,
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<ItemBloc>(context),
                        child: const HomePage()),
                  ),
                );
              })),
          title: const Text('profile Page'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 80,
                  child: Icon(
                    Icons.person,
                    size: 80,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Column(children: [
                Text(
                  "Name: Alazar Lemma",
                  style: TextStyle(color: Colors.green),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Phone Number: ${MobileNumber.mobileNumber.toString()}'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
