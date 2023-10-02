class BestSellerModel {
  List<Sellerdata>? sellerdata;
  String? message;
  int? status;

  BestSellerModel({this.sellerdata, this.message, this.status});

  BestSellerModel.fromJson(Map<String, dynamic> json) {
    if (json['sellerdata'] != null) {
      sellerdata = <Sellerdata>[];
      json['sellerdata'].forEach((v) {
        sellerdata!.add(new Sellerdata.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (sellerdata != null) {
      data['sellerdata'] = this.sellerdata!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Sellerdata {
  List<Products>? products;

  Sellerdata({this.products});

  Sellerdata.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
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

  Products(
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

  Products.fromJson(Map<String, dynamic> json) {
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
