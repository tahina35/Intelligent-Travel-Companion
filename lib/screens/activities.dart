import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/Places/place.dart';
import '../services/firebase/firebase_remote_config_service.dart';
import '../services/places_service.dart';
import '../utils/helper.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {

  final remoteConfigService = FirebaseRemoteConfigService(
    firebaseRemoteConfig: FirebaseRemoteConfig.instance,
  );

  //contexts
  String location = "";
  String weather = "";
  String time = "";

  final placesService = PlacesService();
  List<Place> _places = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    location = remoteConfigService.getLocation();
    weather = remoteConfigService.getWeather();
    time =  Helper.formatTime(remoteConfigService.getTime());

    remoteConfigService.firebaseRemoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfigService.firebaseRemoteConfig.activate();
      print("Remote config updated. Notifying UI to rebuild...");

      setState(() {
        location = remoteConfigService.getLocation();
        weather = remoteConfigService.getWeather();
        time = Helper.formatTime(remoteConfigService.getTime());
      });

    });
    _fetchPlaces();
  }

  void _fetchPlaces() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {

      List<Place> places = await placesService.searchNearby(
        latitude: 45.49699,
        longitude: -73.582895,
        radius: 500,
        types: ["restaurant", "cafe"],
        maxResultCount: 5,
      );

      print(places.length);

      setState(() {
        _places = places;
      });

    } catch(e) {
      setState(() {
        _errorMessage = "Failed to fetch places.";
      });
    } finally {
      // 4. Update loading state
      setState(() {
        _isLoading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(width: 5),
                          Text(
                            time,
                            softWrap: true,
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(width: 5),
                          Text(
                            location,
                            softWrap: true,
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            //TODO: change icon based on weather
                            color: Colors.blueAccent,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '16°  $weather',
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  return _buildActivityCard(_places[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(Place place) {
    return Container(
      height: 330,
      child: Card.outlined(
        color: Colors.transparent,
        margin: EdgeInsets.all(1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 220,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/vieuxport.jpg',
                    fit: BoxFit.cover,
                  )
              ),
            ),

            // Content
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Rating
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Old Port Waterfront",
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.titleMedium,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2F30),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "4.6",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Icon(Icons.star, size: 16, color: Colors.amber),
                      ],
                    ),
                    SizedBox(height: 4),

                    // Type and Distance
                    Text(
                      "Outdoor Walk",
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4),

                    // Reason
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                          size: 13,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "12 min walk",
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.timelapse,
                          color: Colors.blueAccent,
                          size: 13,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Open until 5 PM",
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}