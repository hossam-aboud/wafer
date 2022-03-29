import 'dart:convert';

import 'package:coupons/models/Coupon.dart';

List<Shop> shopFromJson(String str) => List<Shop>.from(json.decode(str).map((x) => Shop.fromJson(x)));

String shopToJson(List<Shop> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shop {
  Shop({
    this.id,
    this.url,
    this.image,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.coupons,
  });

  int id;
  String url;
  String image;
  int active;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  List<Coupon> coupons;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"] ?? 0,
    url: json["url"] ?? null,
    image: json["image"] ?? '',
    active: json["active"] ?? 0,
    name: json["name"] ?? '',
    coupons: json['coupons'] != null ? List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? 0,
    "url": url ?? null,
    "image": image ?? null,
    "active": active ?? 0,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "name": name ?? '',
    "coupons": coupons != null ? List<dynamic>.from(coupons.map((x) => x.toJson())) : null,
  };
}



