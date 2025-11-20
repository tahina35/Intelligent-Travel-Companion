import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/meal_time.dart';
import '../../models/preferences.dart';
import '../../services/preference_service.dart';
import '../../utils/helper.dart';

class EditMealTimePreferences extends StatefulWidget {
  const EditMealTimePreferences({super.key});

  @override
  State<EditMealTimePreferences> createState() => _EditMealTimePreferencesState();
}

class _EditMealTimePreferencesState extends State<EditMealTimePreferences> {

  late Preferences preferences = Preferences.origin(true);

  late Map<String, MealTime> mealTimes = {
    'Breakfast': preferences.mealTime.breakfast,
    'Lunch': preferences.mealTime.lunch,
    'Dinner': preferences.mealTime.dinner,
  };

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    preferences =  await PreferenceService.readData();
    setState(() {
      mealTimes = {
        'Breakfast': preferences.mealTime.breakfast,
        'Lunch': preferences.mealTime.lunch,
        'Dinner': preferences.mealTime.dinner,
      };
    });
  }

  _rangeSlider(MealTime mealTime, double start, double end) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      mealTime.icon,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      mealTime.name,
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: Text(
                    '${Helper.formatTime(mealTime.start)} - ${Helper.formatTime(mealTime.end)}',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            FlutterSlider(
              values: [mealTime.start, mealTime.end],
              handlerHeight: 20,
              handlerWidth: 20,
              jump: true,
              step: FlutterSliderStep(step: 0.5),
              rangeSlider: true,
              max: end,
              min: start,
              onDragging: (_handlerIndex, _lowerValue, _upperValue) {
                MealTime newMealTime = MealTime(icon: mealTime.icon, name: mealTime.name, start: _lowerValue, end: _upperValue);
                setState(() {
                  mealTimes[mealTime.name] = newMealTime;
                });
                switch(mealTime.name) {
                  case 'Breakfast':
                    preferences.mealTime.breakfast = newMealTime;
                    break;
                  case 'Lunch':
                    preferences.mealTime.lunch = newMealTime;
                    break;
                  case 'Dinner':
                    preferences.mealTime.dinner = newMealTime;
                    break;
                }
              },
              handler: FlutterSliderHandler(
                decoration: BoxDecoration(),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ],
                    ),
                    child: Icon(Icons.circle, color: Theme.of(context).colorScheme.primary, size: 18)
                ),
              ),
              rightHandler: FlutterSliderHandler(
                decoration: BoxDecoration(),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ],
                    ),
                    child: Icon(Icons.circle, color: Theme.of(context).colorScheme.primary, size: 18)
                ),
              ),
              tooltip: FlutterSliderTooltip(
                custom: (value) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        Helper.formatTime(value),
                        style:  GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                          )
                        ],
                        borderRadius: BorderRadius.circular(5)
                    ),

                  );
                },
                alwaysShowTooltip: false,
                disabled: false,
              ),
            ),
          ]
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Cuisine Preferences',
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
                  'Drag the handles to edit your typical meal times.',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _rangeSlider(mealTimes['Breakfast']!, 6, 10),
                    _rangeSlider(mealTimes['Lunch']!, 10, 15),
                    _rangeSlider(mealTimes['Dinner']!, 17, 22),
                  ],
                ),
              ),
            ]
          )
        )
      )
    );
  }
}
