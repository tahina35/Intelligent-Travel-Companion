import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermission extends StatelessWidget {
  final Function nextPage;

  const LocationPermission({super.key, required this.nextPage});

  void _requestLocationPermission() async {

    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Recommendation updates',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headlineMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Get notified when your recommendations change based on weather, time, or location.',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Container(
            child: Image.asset('assets/images/bell.png'),
          ),
        ]
    );
  }
}
