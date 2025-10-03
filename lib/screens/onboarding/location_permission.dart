import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itc/utils/helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'onboarding.dart';

class LocationPermission extends StatelessWidget {
  final Function nextPage;

  const LocationPermission({super.key, required this.nextPage});

  void _requestLocationPermission() async {
    if(await Permission.location.isDenied) {
      Permission.location.request();
    }
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Find amazing places near you',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headlineMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'To recommend the best restaurants and activities right where you are, we need access to your location.',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Container(
            child: Image.asset('assets/images/map.jpg'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    nextPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD3D3D3),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Text(
                    "Don't allow",
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: _requestLocationPermission,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Text(
                    "Allow",
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]
          )
        ]
    );
  }
}
