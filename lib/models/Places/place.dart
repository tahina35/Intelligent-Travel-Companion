import 'package:itc/models/Places/photo.dart';
import 'package:itc/models/Places/regular_opening_hours.dart';
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
}
