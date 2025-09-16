import 'package:flutter/material.dart';

class ActivityPreference extends StatefulWidget {
  const ActivityPreference({super.key});

  @override
  State<ActivityPreference> createState() => _ActivityPreferenceState();
}

class _ActivityPreferenceState extends State<ActivityPreference> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Activity Preference'),
    );
  }
}
