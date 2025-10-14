import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/Places/place.dart';
import '../services/places_service.dart';
import '../utils/helper.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {

  final placesService = PlacesService();
  List<Place> _places = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchPlaces();
  }

  void _fetchPlaces() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {

      Position position = await Helper.getCurrentLocation();

      //TODO: implement firebase remote config

      List<Place> places = await placesService.searchNearby(
        latitude: position.latitude,
        longitude: position.longitude,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Plateau-Mont-Royal',
                            softWrap: true,
                            style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.wb_sunny,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '16°',
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Moslty clear',
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