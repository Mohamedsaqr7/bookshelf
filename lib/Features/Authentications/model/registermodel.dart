class RegisterModel {
  Registerdata? registerdata;
  String? message;
  int? status;

  RegisterModel({this.registerdata, this.message, this.status});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    registerdata = json['Registerdata'] != null
        ? Registerdata.fromJson(json['Registerdata'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (registerdata != null) {
      data['Registerdata'] = registerdata!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Registerdata {
  User? user;
  String? token;

  Registerdata({this.user, this.token});

  Registerdata.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token']as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic address;
  dynamic city;
  dynamic phone;
  bool? emailVerified;
  String? image;

  User(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.city,
      this.phone,
      this.emailVerified,
      this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    phone = json['phone'];
    emailVerified = json['email_verified'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['city'] = city;
    data['phone'] = phone;
    data['email_verified'] = emailVerified;
    data['image'] = image;
    return data;
  }
}
