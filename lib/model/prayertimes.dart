class PrayerTimess {
  String? region;
  String? country;
  PrayerTimess? prayerTimes;
  Date? date;
  Meta? meta;

  PrayerTimess(
      {this.region, this.country, this.prayerTimes, this.date, this.meta});

  PrayerTimess.fromJson(Map<String, dynamic> json) {
    region = json['region'];
    country = json['country'];
    prayerTimes = json['prayer_times'] != null
        ? new PrayerTimess.fromJson(json['prayer_times'])
        : null;
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region'] = this.region;
    data['country'] = this.country;
    if (this.prayerTimes != null) {
      data['prayer_times'] = this.prayerTimes!.toJson();
    }
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class PrayerTimes {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;

  PrayerTimes(
      {this.fajr, this.sunrise, this.dhuhr, this.asr, this.maghrib, this.isha});

  PrayerTimes.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fajr'] = this.fajr;
    data['Sunrise'] = this.sunrise;
    data['Dhuhr'] = this.dhuhr;
    data['Asr'] = this.asr;
    data['Maghrib'] = this.maghrib;
    data['Isha'] = this.isha;
    return data;
  }
}

class Date {
  String? dateEn;
  DateHijri? dateHijri;

  Date({this.dateEn, this.dateHijri});

  Date.fromJson(Map<String, dynamic> json) {
    dateEn = json['date_en'];
    dateHijri = json['date_hijri'] != null
        ? new DateHijri.fromJson(json['date_hijri'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_en'] = this.dateEn;
    if (this.dateHijri != null) {
      data['date_hijri'] = this.dateHijri!.toJson();
    }
    return data;
  }
}

class DateHijri {
  String? date;
  String? format;
  String? day;
  Weekday? weekday;
  Month? month;
  String? year;
  Designation? designation;
  List<Null>? holidays;
  List<Null>? adjustedHolidays;
  String? method;

  DateHijri(
      {this.date,
      this.format,
      this.day,
      this.weekday,
      this.month,
      this.year,
      this.designation,
      this.holidays,
      this.adjustedHolidays,
      this.method});

  DateHijri.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
    day = json['day'];
    weekday =
        json['weekday'] != null ? new Weekday.fromJson(json['weekday']) : null;
    month = json['month'] != null ? new Month.fromJson(json['month']) : null;
    year = json['year'];
    designation = json['designation'] != null
        ? new Designation.fromJson(json['designation'])
        : null;
    
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['format'] = this.format;
    data['day'] = this.day;
    if (this.weekday != null) {
      data['weekday'] = this.weekday!.toJson();
    }
    if (this.month != null) {
      data['month'] = this.month!.toJson();
    }
    data['year'] = this.year;
    if (this.designation != null) {
      data['designation'] = this.designation!.toJson();
    }

    data['method'] = this.method;
    return data;
  }
}

class Weekday {
  String? en;
  String? ar;

  Weekday({this.en, this.ar});

  Weekday.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}

class Month {
  int? number;
  String? en;
  String? ar;
  int? days;

  Month({this.number, this.en, this.ar, this.days});

  Month.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    en = json['en'];
    ar = json['ar'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['en'] = this.en;
    data['ar'] = this.ar;
    data['days'] = this.days;
    return data;
  }
}

class Designation {
  String? abbreviated;
  String? expanded;

  Designation({this.abbreviated, this.expanded});

  Designation.fromJson(Map<String, dynamic> json) {
    abbreviated = json['abbreviated'];
    expanded = json['expanded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abbreviated'] = this.abbreviated;
    data['expanded'] = this.expanded;
    return data;
  }
}

class Meta {
  String? timezone;

  Meta({this.timezone});

  Meta.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timezone'] = this.timezone;
    return data;
  }
}
