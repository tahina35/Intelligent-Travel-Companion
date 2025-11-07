import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/Places/place.dart';
import '../models/context.dart';
import '../services/firebase/firebase_remote_config_service.dart';
import '../services/recommender_service.dart';
import '../utils/helper.dart';
import '../utils/resources.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  final remoteConfigService = FirebaseRemoteConfigService(
    firebaseRemoteConfig: FirebaseRemoteConfig.instance,
  );

   late Context current_context;

  final recommenderService = RecommenderService();

  List<Place?> _places = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    current_context = Context(
        location: remoteConfigService.getLocation(),
        weather: remoteConfigService.getWeather(),
        time: Helper.formatTime(remoteConfigService.getTime())
    );

    remoteConfigService.firebaseRemoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfigService.firebaseRemoteConfig.activate();
      print("Remote config updated. Notifying UI to rebuild...");

      setState(() {
        current_context = Context(
            location: remoteConfigService.getLocation(),
            weather: remoteConfigService.getWeather(),
            time: Helper.formatTime(remoteConfigService.getTime())
        );
      });

      _fetchPlaces();

    });

    _fetchPlaces();
  }

  void _fetchPlaces() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {

      List<Place?> places = await recommenderService.fetchRecommendations(current_context);

      setState(() {
        _places = places;
      });

    } catch(e) {
      print(e);
      setState(() {
        _errorMessage = "Failed to fetch places.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(width: 5),
                              Text(
                                current_context.location,
                                softWrap: true,
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(width: 5),
                              Text(
                                current_context.time,
                                softWrap: true,
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Helper.stringToIconData[current_context.weather.toLowerCase()],
                            color: Colors.blueAccent,
                          ),
                          SizedBox(width: 5),
                          Text(
                            current_context.weather,
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
            SizedBox(height: 25),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  return _buildActivityCard(_places[index]!);
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
      height: 340,
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
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: (place.photos != null && place.photos!.isNotEmpty)
                  ? Image.network(
                    place.photos![0].getPhotoURL(Resources.image_max_width, Resources.image_max_height),
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(child: SpinKitCircle(
                                  color: Colors.grey,
                                )
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
                    },
                  ) : const Icon(Icons.image_not_supported, size: 50, color: Colors.grey)
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
                    Text(
                      place.displayName!.text!,
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.titleMedium,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2F30),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    // Type and Distance
                    Text(
                      '${Helper.formatPlaceType(place.types![0])}',
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: _getRatingWidgetList(place)
                    ),
                    SizedBox(height: 3),
                    // Reason
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.directions_walk,
                          color: Colors.blueAccent,
                          size: 13,
                        ),
                        SizedBox(width: 5),
                        Text(
                          place.distanceMatrix,
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 20),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.timelapse,
                              color: Colors.blueAccent,
                              size: 13,
                            ),
                            SizedBox(width: 5),
                            Text(
                              Helper.getCurrentOpeningStatus(remoteConfigService.getTime(), place.regularOpeningHours ?? null),
                              style: GoogleFonts.lato(
                                textStyle: Theme.of(context).textTheme.labelSmall,
                                color: Colors.grey[600]
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]
                        )
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

  List<Widget> _getRatingWidgetList(Place place){
    List<Widget> ratingWidgetList = [];
    double roundedRatingValue = place.rating == null ? 0 : ((place.rating! * 2).round() / 2 );
    double decimalValue = roundedRatingValue - roundedRatingValue.floor();
    int userRatingCount = place.userRatingCount ?? 0;

    ratingWidgetList.add(
      Text(
        '${place.rating ?? 0}',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      )
    );

    ratingWidgetList.add(
        SizedBox(width: 3)
    );

    ratingWidgetList.addAll(
      List.generate(5, (index) {
        if(index + 1 <= roundedRatingValue) {
          return Icon(
              Icons.star,
              size: 16,
              color: Colors.amberAccent
          );
        } else {
          if(decimalValue == 0.5) {
            decimalValue = 0;
            return HalfFilledIcon(
                icon: Icons.star,
                size: 16,
                color: Colors.amberAccent
            );
          } else {
            return Icon(
                Icons.star,
                size: 16,
                color: Colors.grey[400]
            );
          }
        }
      })
    );

    ratingWidgetList.add(
        SizedBox(width: 3)
    );

    ratingWidgetList.add(
        Text(
          "($userRatingCount)",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        )
    );

    return ratingWidgetList;
  }
}

class HalfFilledIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  HalfFilledIcon({required this.icon, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: [0, 0.5, 0.5],
          colors: [color, color, color.withValues(alpha: 0)],
        ).createShader(rect);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(icon, size: size, color: Colors.grey[400]),
      ),
    );
  }
}