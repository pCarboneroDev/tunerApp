import 'package:flutter/material.dart';
import 'package:tuner_app/presentation/settings/ui/settings_page.dart';
import 'package:tuner_app/presentation/songs/songs_screen.dart';
import 'package:tuner_app/presentation/tuner/tuner_page.dart';


class BottomNavbarPage extends StatefulWidget {

  @override
  State<BottomNavbarPage> createState() => _BottomNavbarPageState();
}

class _BottomNavbarPageState extends State<BottomNavbarPage> {
  final List<Widget> pages = [TunerPage(), SongsPage(), SettingsPage()];

  int selectedIndex = 0;

  void setSelectedIndex(int value){
    selectedIndex = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "label"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "label"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "label"),
        ],
        currentIndex: selectedIndex,
        onTap: (value) {
          setSelectedIndex(value);
        },
      ),
      body: Center(
        child: pages[selectedIndex],
     ),
   );
  }
}