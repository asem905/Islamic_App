class QuaranPages {
  String? status;
  int? totalPages;
  List<Pages>? pages;

  QuaranPages({this.status, this.totalPages, this.pages});

  QuaranPages.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalPages = json['total_pages'];
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(new Pages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total_pages'] = this.totalPages;
    if (this.pages != null) {
      data['pages'] = this.pages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pages {
  int? pageNumber;
  String? pageUrl;

  Pages({this.pageNumber, this.pageUrl});

  Pages.fromJson(Map<String, dynamic> json) {
    pageNumber = json['page_number'];
    pageUrl = json['page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_number'] = this.pageNumber;
    data['page_url'] = this.pageUrl;
    return data;
  }
}
