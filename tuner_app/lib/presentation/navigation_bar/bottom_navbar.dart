import 'package:flutter/material.dart';
import 'package:tuner_app/presentation/tuner/tuner_screen.dart';


class BottomNavbarPage extends StatelessWidget {

  final List<Widget> pages = [TunerScreen(), TunerScreen(), TunerScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "label"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "label"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "label"),
        ]),
      body: Center(
        child: Text('Hola Mundo'),
     ),
   );
  }
}