class Photos {
  String? name;
  int? widthPx;
  int? heightPx;
  List<AuthorAttributions>? authorAttributions;
  String? flagContentUri;
  String? googleMapsUri;

  Photos(
      {this.name,
        this.widthPx,
        this.heightPx,
        this.authorAttributions,
        this.flagContentUri,
        this.googleMapsUri});

  Photos.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    widthPx = json['widthPx'];
    heightPx = json['heightPx'];
    if (json['authorAttributions'] != null) {
      authorAttributions = <AuthorAttributions>[];
      json['authorAttributions'].forEach((v) {
        authorAttributions!.add(new AuthorAttributions.fromJson(v));
      });
    }
    flagContentUri = json['flagContentUri'];
    googleMapsUri = json['googleMapsUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['widthPx'] = this.widthPx;
    data['heightPx'] = this.heightPx;
    if (this.authorAttributions != null) {
      data['authorAttributions'] =
          this.authorAttributions!.map((v) => v.toJson()).toList();
    }
    data['flagContentUri'] = this.flagContentUri;
    data['googleMapsUri'] = this.googleMapsUri;
    return data;
  }
}

class AuthorAttributions {
  String? displayName;
  String? uri;
  String? photoUri;

  AuthorAttributions({this.displayName, this.uri, this.photoUri});

  AuthorAttributions.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    uri = json['uri'];
    photoUri = json['photoUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['uri'] = this.uri;
    data['photoUri'] = this.photoUri;
    return data;
  }
}