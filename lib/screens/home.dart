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
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 10, // Blur radius
              offset: Offset(0, 3), // Offset for shadow position
            ),
          ],
        ),
        child: SlidingClippedNavBar(
          backgroundColor: Color(0xFFEDEDED),
          onButtonPressed: changePage,
          iconSize: 30,
          activeColor: Theme.of(context).colorScheme.primary,
          selectedIndex: _selectedIndex,
          barItems: [
            BarItem(
              icon: Icons.explore_outlined,
              title: 'Explore',
            ),
            BarItem(
              icon: Icons.tune,
              title: 'Settings',
            ),
            /// Add more BarItem if you want
          ],
        ),
      ),
    );
  }
}
