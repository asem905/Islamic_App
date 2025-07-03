class TafseerModel {
  int? tafseerId;
  String? tafseerName;
  String? ayahUrl;
  int? ayahNumber;
  String? text;

  TafseerModel(
      {this.tafseerId,
      this.tafseerName,
      this.ayahUrl,
      this.ayahNumber,
      this.text});

  TafseerModel.fromJson(Map<String, dynamic> json) {
    tafseerId = json['tafseer_id'];
    tafseerName = json['tafseer_name'];
    ayahUrl = json['ayah_url'];
    ayahNumber = json['ayah_number'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tafseer_id'] = this.tafseerId;
    data['tafseer_name'] = this.tafseerName;
    data['ayah_url'] = this.ayahUrl;
    data['ayah_number'] = this.ayahNumber;
    data['text'] = this.text;
    return data;
  }
}
