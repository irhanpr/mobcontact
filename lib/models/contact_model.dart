class Contact {
  int? id;
  String? name;
  String? mobileNo;
  String? email;
  String? company;
  String? photo;

  Contact(
      {this.id,
      this.name,
      this.mobileNo,
      this.company,
      this.email,
      this.photo});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      mobileNo: json['mobileNo'],
      email: json['email'],
      company: json['company'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    if (id != null) {
      json['id'] = id;
    }
    json['name'] = name;
    json['mobileNo'] = mobileNo;
    json['email'] = email;
    json['company'] = company;
    json['photo'] = photo;
    return json;
  }
}
