import 'package:flutter/material.dart';
import 'package:itc/screens/preferences.dart';
import 'package:itc/screens/map.dart';
import 'package:itc/screens/activities.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Activities(),
    Map(),
    Preferences()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(_selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _widgetOptions,
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: changePage,
        iconSize: 30,
        activeColor: Color(0xFF01579B),
        selectedIndex: _selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.local_activity,
            title: 'Activities',
          ),
          BarItem(
            icon: Icons.map,
            title: 'Map',
          ),
          BarItem(
            icon: Icons.tune,
            title: 'Preferences',
          ),
          /// Add more BarItem if you want
        ],
      ),
    );
  }
}
