import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itc/utils/helper.dart';
import '../../models/meal_time.dart';
import '../../models/meal_time_preference.dart';
import '../../models/preferences.dart';

class MealTimePreference extends StatefulWidget {
  final Preferences preferences;
  const MealTimePreference({super.key, required this.preferences});

  @override
  State<MealTimePreference> createState() => _MealTimePreferenceState();
}

class _MealTimePreferenceState extends State<MealTimePreference> {

  late Map<String, MealTime> mealTimes = {
    'Breakfast': widget.preferences.mealTime.breakfast,
    'Lunch': widget.preferences.mealTime.lunch,
    'Dinner': widget.preferences.mealTime.dinner,
  };

  _rangeSlider(MealTime mealTime) {
    return Column(
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
          max: 24,
          min: 0,
          onDragging: (_handlerIndex, _lowerValue, _upperValue) {
            MealTime newMealTime = MealTime(icon: mealTime.icon, name: mealTime.name, start: _lowerValue, end: _upperValue);
            setState(() {
              mealTimes[mealTime.name] = newMealTime;
            });
            switch(mealTime.name) {
              case 'Breakfast':
                widget.preferences.mealTime.breakfast = newMealTime;
                break;
              case 'Lunch':
                widget.preferences.mealTime.lunch = newMealTime;
                break;
              case 'Dinner':
                widget.preferences.mealTime.dinner = newMealTime;
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'When do you like to eat?',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headlineMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Drag the handles to set your typical meal times.',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _rangeSlider(mealTimes['Breakfast']!),
                  _rangeSlider(mealTimes['Lunch']!),
                  _rangeSlider(mealTimes['Dinner']!),
                ],
              ),
            )
          ),
        ]
    );
  }
}
