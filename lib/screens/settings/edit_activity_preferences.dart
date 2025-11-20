import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itc/models/preferences.dart';
import '../../models/activity_type.dart';
import '../../services/activity_service.dart';
import '../../services/preference_service.dart';

class EditActivityPreferences extends StatefulWidget {
  const EditActivityPreferences({super.key});

  @override
  State<EditActivityPreferences> createState() => _EditActivityPreferencesState();
}

class _EditActivityPreferencesState extends State<EditActivityPreferences> {

  int selectedOption = 1;
  final activityService = ActivityService();
  late Preferences preferences = Preferences.origin(true);
  List<ActivityType> options = [];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    preferences =  await PreferenceService.readData();
    setState(() {
      selectedOption = preferences.activityType.id; // Set the initial selected option
    });
    getActivities(); // get activities from db
  }

  Future<void> getActivities() async {

    final data = await activityService.getActivities().then((activities) {
      return activities.map((activity) => ActivityType.fromMap(activity)).toList();
    });

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

      preferences.activityType = options[index - 1];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Activity Preference',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30.0),
                  child: Text(
                    'What kind of activities do you prefer?',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: options.map((option) {

                    bool isSelected = false;
                    print(selectedOption);
                    if(selectedOption > 0) {
                      isSelected = selectedOption == option.id;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Container(
                        height: 179,
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
                                            image: AssetImage('assets/images/${option.image}'),
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

              ]
          ),
        ),
      )
    );
  }
}

