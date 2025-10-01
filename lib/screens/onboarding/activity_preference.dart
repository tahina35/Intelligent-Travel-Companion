import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itc/models/activity_type.dart';
import 'package:itc/services/activity_service.dart';

import '../../models/preferences.dart';

class ActivityPreference extends StatefulWidget {

  final Preferences preferences;
  const ActivityPreference({super.key, required this.preferences});

  @override
  State<ActivityPreference> createState() => _ActivityPreferenceState();
}

class _ActivityPreferenceState extends State<ActivityPreference> {

  int selectedOption = -1;
  final activityService = ActivityService();
  List<ActivityType> options = [];

  @override
  void initState() {
    super.initState();
    getActivities();
  }

  Future<void> getActivities() async {

    final data = await activityService.getActivities().then((activities) {
      return activities.map((activity) => ActivityType.fromMap(activity)).toList();
    });

    print(data);

    setState(() {
      options = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    void selectOption(int index) {
      setState(() {
        selectedOption = index;
      });

      widget.preferences.activityType = options[index];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
            'What\'s your vibe?',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headlineMedium,
              fontWeight: FontWeight.w600,
            ),
        ),
        SizedBox(height: 10),
        Text(
            'Select your preferred activity type.',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
        ),
        SizedBox(height: 30),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: options.map((option) {

              bool isSelected = false;
              if(selectedOption >= 0) {
                isSelected = selectedOption == option.id;
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Card(
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: isSelected
                        ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.7)
                        : Colors.grey.withValues(alpha: 0.2),
                        width: isSelected ? 3.0 : 2.0,
                        style: BorderStyle.solid
                      ),
                    ),
                    elevation: 2,
                    child: Ink(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          selectOption(option.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Ink.image(
                                  image: AssetImage('assets/${option.image}'),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        option.label,
                                        style: GoogleFonts.lato(
                                          textStyle: Theme.of(context).textTheme.bodyLarge,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        option.description,
                                        style: GoogleFonts.lato(
                                          textStyle: Theme.of(context).textTheme.bodySmall,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                    )
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ]
    );
  }
}
