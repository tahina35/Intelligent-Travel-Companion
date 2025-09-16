import 'package:flutter/material.dart';

class MealTimePreference extends StatefulWidget {
  const MealTimePreference({super.key});

  @override
  State<MealTimePreference> createState() => _MealTimePreferenceState();
}

class _MealTimePreferenceState extends State<MealTimePreference> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Meal Time Preference'),
    );
  }
}
