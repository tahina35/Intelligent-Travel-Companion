import 'package:itc/models/Places/photo.dart';
import 'package:itc/models/Places/regular_opening_hours.dart';
import 'package:itc/models/Places/types.dart';
import 'display_name.dart';
import 'location.dart';

class Place {
  String? name;
  List<String>? types;
  String? formattedAddress;
  Location? location;
  double? rating;
  int? userRatingCount;
  RegularOpeningHours? regularOpeningHours;
  DisplayName? displayName;
  List<Photo>? photos;
  late String distanceMatrix;
  late double score;
  late Types primaryType;

  Place(
      {this.name,
        this.types,
        this.formattedAddress,
        this.location,
        this.rating,
        this.userRatingCount,
        this.regularOpeningHours,
        this.displayName,
        this.photos});

  Place.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    types = json['types'].cast<String>();
    formattedAddress = json['formattedAddress'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    rating = json['rating']?.toDouble();
    userRatingCount = json['userRatingCount'];
    regularOpeningHours = json['regularOpeningHours'] != null
        ? new RegularOpeningHours.fromJson(json['regularOpeningHours'])
        : null;
    displayName = json['displayName'] != null
        ? new DisplayName.fromJson(json['displayName'])
        : null;
    if (json['photos'] != null) {
      photos = <Photo>[];
      json['photos'].forEach((v) {
        photos!.add(new Photo.fromJson(v));
      });
    }
    findPrimaryType();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['types'] = this.types;
    data['formattedAddress'] = this.formattedAddress;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['rating'] = this.rating;
    data['userRatingCount'] = this.userRatingCount;
    if (this.regularOpeningHours != null) {
      data['regularOpeningHours'] = this.regularOpeningHours!.toJson();
    }
    if (this.displayName != null) {
      data['displayName'] = this.displayName!.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool isPlaceOpen(double time) {

    bool isOpen = false;

    final now = DateTime.now();
    int currentDay = now.weekday - 1;
    int currentTime = (time * 100).toInt(); // e.g., 13.5 -> 1350

    final periods = this.regularOpeningHours?.periods;
    if (periods == null || periods.length == 1) { // place is open 24 h
      return true;
    }

    for (final period in periods) {
      final openInfo = period.open;
      final closeInfo = period.close;

      if (openInfo == null || closeInfo == null) continue;

      int openDay = openInfo.day!;
      int openTime = (openInfo.hour! * 100) + openInfo.minute!;
      int closeDay = closeInfo.day!;
      int closeTime = (closeInfo.hour! * 100) + closeInfo.minute!;

      // Case 1: Opens and closes on the same day.
      if (openDay == closeDay) {
        if (currentDay == openDay && currentTime >= openTime && currentTime < closeTime) {
          isOpen = true;
          break;
        }
      }
      // Case 2: Opens one day and closes the next (overnight).
      else {
        // Check if we are on the opening day, after the opening time.
        if (currentDay == openDay && currentTime >= openTime) {
          isOpen = true;
          break;
        }
        // Check if we are on the closing day, before the closing time.
        if (currentDay == closeDay && currentTime < closeTime) {
          isOpen = true;
          break;
        }
      }
    }

    return isOpen;
  }

  void findPrimaryType() {
    for(String placeType in this.types!) {
      try {
        primaryType = Types.values.byName(placeType);
        score = primaryType.baseScore;
        break;
      }  catch(e) {
        continue;
      }
    }
  }
}
