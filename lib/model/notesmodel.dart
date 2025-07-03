class Notesmodel {
  int? id;
  String? title;
  String? content;
  String? date;

  Notesmodel({this.id, this.title, this.content, this.date});

  Notesmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
  }

}