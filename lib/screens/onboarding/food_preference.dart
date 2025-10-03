import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/preferences.dart';

class FoodPreference extends StatefulWidget {
  final Preferences preferences;
  const FoodPreference({super.key, required this.preferences});

  @override
  State<FoodPreference> createState() => _FoodPreferenceState();
}

class _FoodPreferenceState extends State<FoodPreference> {

  List<String> choices = [
    '🍕 Pizza',
    '🍣 Japanese',
    '🌮 Mexican',
    '🍔 Burgers',
    '🍛 Indian',
    '🥐 French',
    '🧀 Poutine',
    '☕ Café & Brunch',
    '🥗 Healthy',
    '🥢 Chinese',
    '🌱 Vegetarian',
    '🍗 American',
    '🌿 Vegan',
    '☀️ Gluten-Free',
    '🥖 Bakery'
  ];

  List<String> selectedValue = [];

  initState() {
    super.initState();
    selectedValue = widget.preferences.foodPreferences;
  }

  void setSelectedValue(List<String> value) {
    setState(() => selectedValue = value);
    widget.preferences.foodPreferences = selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Let\'s talk about food',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headlineMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Select your favorite cuisines to tailor your dining recommendations.',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Expanded(
            child: InlineChoice<String>(
              multiple: true,
              clearable: true,
              value: selectedValue,
              onChanged: setSelectedValue,
              itemCount: choices.length,
              itemBuilder: (selection, i) {
                return ChoiceChip(
                  selected: selection.selected(choices[i]),
                  onSelected: selection.onSelected(choices[i]),
                  label: Text(
                      choices[i],
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        color: selection.selected(choices[i]) ? Colors.white : Colors.black,
                      ),
                  ),
                  selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
                  showCheckmark: false,
                  surfaceTintColor: Colors.blue,
                  shadowColor: Colors.transparent,
                  selectedShadowColor: Colors.blue,
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                      color: selection.selected(choices[i])
                          ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.7)
                          : Colors.grey.withValues(alpha: 0.5),
                      width: selection.selected(choices[i]) ? 0 : 1.0,
                  ),

                );
              },
              listBuilder: ChoiceList.createWrapped(
                spacing: 10,
                runSpacing: 10,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
              ),
            ),
          ),
        ]
    );
  }
}
