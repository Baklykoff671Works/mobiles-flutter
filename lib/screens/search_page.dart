import 'package:flutter/material.dart';
import 'package:flutter_test_project/elements/appbar.dart';
import 'package:flutter_test_project/elements/navbar.dart';
import 'package:mylightplugin/mylightplugin.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {


  int? _batteryLevel;

  @override
  void initState() {
    super.initState();

    // execute the method to retrieve the battery level
    my.getBatteryLevel().then((battery) {
      setState(() {
        _batteryLevel = battery;
      });
    });
  }

  Mylightplugin my = Mylightplugin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isAbleGoBack: false,
        appTitle: 'Light your art',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Percentage: $_batteryLevel',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
            const IconButton(
              icon: Icon(
                Icons.flashlight_on,
                color: Colors.black,
                size: 40,
              ),
              onPressed: Mylightplugin.turnOnLight,
            ),
            const IconButton(
              icon: Icon(
                Icons.flashlight_off,
                color: Colors.black,
                size: 40,
              ),
              onPressed: Mylightplugin.turnOffLight,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
