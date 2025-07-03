class AthkarModel {
  List<MorningAzkar>? morningAzkar;
  List<EveningAzkar>? eveningAzkar;
  List<PrayerAzkar>? prayerAzkar;
  List<PrayerLaterAzkar>? prayerLaterAzkar;
  List<SleepAzkar>? sleepAzkar;
  List<WakeUpAzkar>? wakeUpAzkar;
  List<MosqueAzkar>? mosqueAzkar;
  List<MiscellaneousAzkar>? miscellaneousAzkar;
  List<AdhanAzkar>? adhanAzkar;
  List<WuduAzkar>? wuduAzkar;
  List<HomeAzkar>? homeAzkar;
  List<KhalaAzkar>? khalaAzkar;
  List<FoodAzkar>? foodAzkar;
  List<HajjAndUmrahAzkar>? hajjAndUmrahAzkar;

  AthkarModel(
      {this.morningAzkar,
      this.eveningAzkar,
      this.prayerAzkar,
      this.prayerLaterAzkar,
      this.sleepAzkar,
      this.wakeUpAzkar,
      this.mosqueAzkar,
      this.miscellaneousAzkar,
      this.adhanAzkar,
      this.wuduAzkar,
      this.homeAzkar,
      this.khalaAzkar,
      this.foodAzkar,
      this.hajjAndUmrahAzkar});

  AthkarModel.fromJson(Map<String, dynamic> json) {
    if (json['morning_azkar'] != null) {
      morningAzkar = <MorningAzkar>[];
      json['morning_azkar'].forEach((v) {
        morningAzkar!.add(new MorningAzkar.fromJson(v));
      });
    }
    if (json['evening_azkar'] != null) {
      eveningAzkar = <EveningAzkar>[];
      json['evening_azkar'].forEach((v) {
        eveningAzkar!.add(new EveningAzkar.fromJson(v));
      });
    }
    if (json['prayer_azkar'] != null) {
      prayerAzkar = <PrayerAzkar>[];
      json['prayer_azkar'].forEach((v) {
        prayerAzkar!.add(new PrayerAzkar.fromJson(v));
      });
    }
    if (json['prayer_later_azkar'] != null) {
      prayerLaterAzkar = <PrayerLaterAzkar>[];
      json['prayer_later_azkar'].forEach((v) {
        prayerLaterAzkar!.add(new PrayerLaterAzkar.fromJson(v));
      });
    }
    if (json['sleep_azkar'] != null) {
      sleepAzkar = <SleepAzkar>[];
      json['sleep_azkar'].forEach((v) {
        sleepAzkar!.add(new SleepAzkar.fromJson(v));
      });
    }
    if (json['wake_up_azkar'] != null) {
      wakeUpAzkar = <WakeUpAzkar>[];
      json['wake_up_azkar'].forEach((v) {
        wakeUpAzkar!.add(new WakeUpAzkar.fromJson(v));
      });
    }
    if (json['mosque_azkar'] != null) {
      mosqueAzkar = <MosqueAzkar>[];
      json['mosque_azkar'].forEach((v) {
        mosqueAzkar!.add(new MosqueAzkar.fromJson(v));
      });
    }
    if (json['miscellaneous_azkar'] != null) {
      miscellaneousAzkar = <MiscellaneousAzkar>[];
      json['miscellaneous_azkar'].forEach((v) {
        miscellaneousAzkar!.add(new MiscellaneousAzkar.fromJson(v));
      });
    }
    if (json['adhan_azkar'] != null) {
      adhanAzkar = <AdhanAzkar>[];
      json['adhan_azkar'].forEach((v) {
        adhanAzkar!.add(new AdhanAzkar.fromJson(v));
      });
    }
    if (json['wudu_azkar'] != null) {
      wuduAzkar = <WuduAzkar>[];
      json['wudu_azkar'].forEach((v) {
        wuduAzkar!.add(new WuduAzkar.fromJson(v));
      });
    }
    if (json['home_azkar'] != null) {
      homeAzkar = <HomeAzkar>[];
      json['home_azkar'].forEach((v) {
        homeAzkar!.add(new HomeAzkar.fromJson(v));
      });
    }
    if (json['khala_azkar'] != null) {
      khalaAzkar = <KhalaAzkar>[];
      json['khala_azkar'].forEach((v) {
        khalaAzkar!.add(new KhalaAzkar.fromJson(v));
      });
    }
    if (json['food_azkar'] != null) {
      foodAzkar = <FoodAzkar>[];
      json['food_azkar'].forEach((v) {
        foodAzkar!.add(new FoodAzkar.fromJson(v));
      });
    }
    if (json['hajj_and_umrah_azkar'] != null) {
      hajjAndUmrahAzkar = <HajjAndUmrahAzkar>[];
      json['hajj_and_umrah_azkar'].forEach((v) {
        hajjAndUmrahAzkar!.add(new HajjAndUmrahAzkar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.morningAzkar != null) {
      data['morning_azkar'] =
          this.morningAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.eveningAzkar != null) {
      data['evening_azkar'] =
          this.eveningAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.prayerAzkar != null) {
      data['prayer_azkar'] = this.prayerAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.prayerLaterAzkar != null) {
      data['prayer_later_azkar'] =
          this.prayerLaterAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.sleepAzkar != null) {
      data['sleep_azkar'] = this.sleepAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.wakeUpAzkar != null) {
      data['wake_up_azkar'] = this.wakeUpAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.mosqueAzkar != null) {
      data['mosque_azkar'] = this.mosqueAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.miscellaneousAzkar != null) {
      data['miscellaneous_azkar'] =
          this.miscellaneousAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.adhanAzkar != null) {
      data['adhan_azkar'] = this.adhanAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.wuduAzkar != null) {
      data['wudu_azkar'] = this.wuduAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.homeAzkar != null) {
      data['home_azkar'] = this.homeAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.khalaAzkar != null) {
      data['khala_azkar'] = this.khalaAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.foodAzkar != null) {
      data['food_azkar'] = this.foodAzkar!.map((v) => v.toJson()).toList();
    }
    if (this.hajjAndUmrahAzkar != null) {
      data['hajj_and_umrah_azkar'] =
          this.hajjAndUmrahAzkar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Azkar {
  int? id;
  String? text;
  int? count;

  Azkar({this.id, this.text, this.count});

  Azkar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['count'] = this.count;
    return data;
  }
}

class EveningAzkar extends Azkar {
  EveningAzkar.fromJson(super.json) : super.fromJson();
}

class MorningAzkar extends Azkar {
  MorningAzkar.fromJson(super.json) : super.fromJson();
}
class PrayerAzkar extends Azkar {
  PrayerAzkar.fromJson(super.json) : super.fromJson();
}
class PrayerLaterAzkar extends Azkar {
  PrayerLaterAzkar.fromJson(super.json) : super.fromJson();
}
class SleepAzkar extends Azkar {
  SleepAzkar.fromJson(super.json) : super.fromJson();
}
class WakeUpAzkar extends Azkar {
  WakeUpAzkar.fromJson(super.json) : super.fromJson();
}
class MosqueAzkar extends Azkar {
  MosqueAzkar.fromJson(super.json) : super.fromJson();
}
class MiscellaneousAzkar extends Azkar {
  MiscellaneousAzkar.fromJson(super.json) : super.fromJson();
}
class AdhanAzkar extends Azkar {
  AdhanAzkar.fromJson(super.json) : super.fromJson();
}
class WuduAzkar extends Azkar {
  WuduAzkar.fromJson(super.json) : super.fromJson();
}
class HomeAzkar extends Azkar {
  HomeAzkar.fromJson(super.json) : super.fromJson();
}
class KhalaAzkar extends Azkar {
  KhalaAzkar.fromJson(super.json) : super.fromJson();
}
class FoodAzkar extends Azkar {
  FoodAzkar.fromJson(super.json) : super.fromJson();
}
class HajjAndUmrahAzkar extends Azkar {
  HajjAndUmrahAzkar.fromJson(super.json) : super.fromJson();
}

