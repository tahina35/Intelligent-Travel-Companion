class RegularOpeningHours {
  bool? openNow;
  List<Periods>? periods;
  List<String>? weekdayDescriptions;
  String? nextCloseTime;

  RegularOpeningHours(
      {this.openNow,
        this.periods,
        this.weekdayDescriptions,
        this.nextCloseTime});

  RegularOpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['openNow'];
    if (json['periods'] != null) {
      periods = <Periods>[];
      json['periods'].forEach((v) {
        periods!.add(new Periods.fromJson(v));
      });
    }
    weekdayDescriptions = json['weekdayDescriptions'].cast<String>();
    nextCloseTime = json['nextCloseTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openNow'] = this.openNow;
    if (this.periods != null) {
      data['periods'] = this.periods!.map((v) => v.toJson()).toList();
    }
    data['weekdayDescriptions'] = this.weekdayDescriptions;
    data['nextCloseTime'] = this.nextCloseTime;
    return data;
  }
}

class Periods {
  Open? open;
  Open? close;

  Periods({this.open, this.close});

  Periods.fromJson(Map<String, dynamic> json) {
    open = json['open'] != null ? new Open.fromJson(json['open']) : null;
    close = json['close'] != null ? new Open.fromJson(json['close']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.open != null) {
      data['open'] = this.open!.toJson();
    }
    if (this.close != null) {
      data['close'] = this.close!.toJson();
    }
    return data;
  }
}

class Open {
  int? day;
  int? hour;
  int? minute;

  Open({this.day, this.hour, this.minute});

  Open.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    return data;
  }
}