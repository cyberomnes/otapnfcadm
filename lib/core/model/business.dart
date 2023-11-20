// ignore_for_file: prefer_collection_literals, unnecessary_this

class BusinessModel {
  int? status;
  String? message;
  List<BusinessData>? data;

  BusinessModel({this.status, this.message, this.data});

  BusinessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BusinessData>[];
      json['data'].forEach((v) {
        data!.add(BusinessData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessData {
  String? title;
  String? subtitle;
  String? logo;
  String? domain;
  String? links;
  String? subdomain;
  String? qrcodeBase64;

  BusinessData(
      {this.title,
        this.subtitle,
        this.logo,
        this.domain,
        this.links,
        this.subdomain,
        this.qrcodeBase64});

  BusinessData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    logo = json['logo'];
    domain = json['domain'];
    links = json['links'];
    subdomain = json['subdomain'];
    qrcodeBase64 = json['qrcode_base64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['logo'] = this.logo;
    data['domain'] = this.domain;
    data['links'] = this.links;
    data['subdomain'] = this.subdomain;
    data['qrcode_base64'] = this.qrcodeBase64;
    return data;
  }
}
