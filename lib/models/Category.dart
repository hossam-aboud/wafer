import 'dart:convert';

import 'package:coupons/models/Coupon.dart';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.image,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.coupons,
  });

  int id;
  String image;
  int active;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  List<Coupon> coupons;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] ?? 0,
    image: json["image"] ?? '',
    active: json["active"] ?? 0,
    name: json["name"] ?? '',
    coupons: json['coupons'] != null ? List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? 0,
    "image": image ?? null,
    "active": active ?? 0,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "name": name ?? '',
    "coupons": coupons != null ? List<dynamic>.from(coupons.map((x) => x.toJson())) : null,
  };
}



