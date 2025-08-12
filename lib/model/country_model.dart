class CountryModel {
  Name? name;
  Flags? flags;

  CountryModel({this.name, this.flags});

  CountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    flags = json['flags'] != null ? new Flags.fromJson(json['flags']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.flags != null) {
      data['flags'] = this.flags!.toJson();
    }
    return data;
  }
}

class Name {
  String? common;
  String? official;

  Name({this.common, this.official});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'];
    official = json['official'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['common'] = this.common;
    data['official'] = this.official;
    return data;
  }
}

class Flags {
  String? png;
  String? svg;

  Flags({this.png, this.svg});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'];
    svg = json['svg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['png'] = this.png;
    data['svg'] = this.svg;
    return data;
  }
}