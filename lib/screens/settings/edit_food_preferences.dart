import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/preferences.dart';
import '../../services/preference_service.dart';
import '../../utils/helper.dart';

class EditFoodPreferences extends StatefulWidget {
  const EditFoodPreferences({super.key});

  @override
  State<EditFoodPreferences> createState() => _EditFoodPreferencesState();
}

class _EditFoodPreferencesState extends State<EditFoodPreferences> {
  List<String> choices = Helper.getCuisineOptions();
  late Preferences preferences = Preferences.origin(true);
  List<String> selectedValue = [];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    preferences =  await PreferenceService.readData();
    setState(() {
      selectedValue = preferences.foodPreferences;
    });
  }

  void setSelectedValue(List<String> value) {
    setState(() => selectedValue = value);
    preferences.foodPreferences = selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    print('food pref = $selectedValue');
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
                    'Select your favorite cuisines to tailor your dining recommendations.',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
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
          ),
        ),
      ),
    );
  }
}
