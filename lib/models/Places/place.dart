import 'package:itc/models/Places/photos.dart';
import 'display_name.dart';
import 'location.dart';

class Place {
  String? name;
  List<String>? types;
  String? formattedAddress;
  Location? location;
  DisplayName? displayName;
  List<Photos>? photos;

  Place(
      {this.name,
        this.types,
        this.formattedAddress,
        this.location,
        this.displayName,
        this.photos});

  Place.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    types = json['types'].cast<String>();
    formattedAddress = json['formattedAddress'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    displayName = json['displayName'] != null
        ? new DisplayName.fromJson(json['displayName'])
        : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
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
    if (this.displayName != null) {
      data['displayName'] = this.displayName!.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
