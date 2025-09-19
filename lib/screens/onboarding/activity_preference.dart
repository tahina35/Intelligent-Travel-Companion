import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityPreference extends StatefulWidget {
  const ActivityPreference({super.key});

  @override
  State<ActivityPreference> createState() => _ActivityPreferenceState();
}

class _ActivityPreferenceState extends State<ActivityPreference> {

  int selectedOption = -1;

  List<Map<String, String>> options = [
    {
      'index': '0',
      'image': 'indoor_.png',
      'label': 'Indoor',
      'description': 'Enjoy museums, cozy cafés, and unique shops.'
    },
    {
      'index': '1',
      'image': 'outdoor_.jpg',
      'label': 'Outdoor',
      'description': 'Discover parks, iconic streets, and outdoor sights.'
    },
    {
      'index': '2',
      'image': 'both_.png',
      'label': 'Both',
      'description': 'Get a mix of the best indoor and outdoor experiences.'
    },
  ];

  @override
  Widget build(BuildContext context) {

    void selectOption(int index) {
      setState(() {
        selectedOption = index;
      });
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
                isSelected = selectedOption == int.parse(option['index']!);
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Card(
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
                    elevation: 0,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        selectOption(int.parse(option['index']!));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Ink.image(
                                image: AssetImage('assets/${option['image']}'),
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
                                      option['label']!,
                                      style: GoogleFonts.lato(
                                        textStyle: Theme.of(context).textTheme.bodyLarge,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      option['description']!,
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
