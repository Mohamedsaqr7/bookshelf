class NewArrivalModel {
  Arrivaldata? arrivaldata;
  String? message;
  List<dynamic>? error;
  int? status;

  NewArrivalModel({this.arrivaldata, this.message, this.error, this.status});

  NewArrivalModel.fromJson(Map<String, dynamic> json) {
    arrivaldata = json['arrivaldata'] != null
        ? Arrivaldata.fromJson(json['arrivaldata'])
        : null;
    message = json['message'];
    error=
    json['error'] as List<dynamic>?;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (arrivaldata != null) {
      data['arrivaldata'] = arrivaldata!.toJson();
    }
    data['message'] = message;
    if (error != null) {
      data['error'] = error!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Arrivaldata {
  List<Arrivalproducts>? arrivalproducts;

  Arrivaldata({this.arrivalproducts});

  Arrivaldata.fromJson(Map<String, dynamic> json) {
    if (json['arrivalproducts'] != null) {
      arrivalproducts = <Arrivalproducts>[];
      json['arrivalproducts'].forEach((v) {
        arrivalproducts!.add(Arrivalproducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (arrivalproducts != null) {
      data['arrivalproducts'] =
          arrivalproducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Arrivalproducts {
  int? id;
  String? name;
  String? description;
  String? price;
  int? discount;
  double? priceAfterDiscount;
  int? stock;
  int? bestSeller;
  String? image;
  String? category;

  Arrivalproducts(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.discount,
      this.priceAfterDiscount,
      this.stock,
      this.bestSeller,
      this.image,
      this.category});

  Arrivalproducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    priceAfterDiscount = json['price_after_discount'];
    stock = json['stock'];
    bestSeller = json['best_seller'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['discount'] = discount;
    data['price_after_discount'] = priceAfterDiscount;
    data['stock'] = stock;
    data['best_seller'] = bestSeller;
    data['image'] = image;
    data['category'] = category;
    return data;
  }
}
