class SliderModel {
  Sliderdata? sliderdata;
  String? message;
  List<dynamic>? error;
  int? status;

  SliderModel({this.sliderdata, this.message, this.error, this.status});

  SliderModel.fromJson(Map<String, dynamic> json) {
    sliderdata = json['sliderdata'] != null
        ? Sliderdata.fromJson(json['sliderdata'])
        : null;
    message = json['message'];
    json['error'] as List<dynamic>?;

    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (sliderdata != null) {
      data['sliderdata'] = sliderdata!.toJson();
    }
    data['message'] = message;
    if (error != null) {
      data['error'] = error!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Sliderdata {
  List<Sliders>? sliders;

  Sliderdata({this.sliders});

  Sliderdata.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (sliders != null) {
      data['sliders'] = sliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  String? image;

  Sliders({this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = image;
    return data;
  }
}
