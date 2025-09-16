import 'package:flutter/material.dart';

class FoodPreference extends StatefulWidget {
  const FoodPreference({super.key});

  @override
  State<FoodPreference> createState() => _FoodPreferenceState();
}

class _FoodPreferenceState extends State<FoodPreference> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Food Preference'),
    );
  }
}
