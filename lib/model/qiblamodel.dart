class QiblaModel {
  int? code;
  String? status;
  Data? data;

  QiblaModel({this.code, this.status, this.data});

  QiblaModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  double? latitude;
  double? longitude;
  double? direction;

  Data({this.latitude, this.longitude, this.direction});

  Data.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['direction'] = this.direction;
    return data;
  }
}
