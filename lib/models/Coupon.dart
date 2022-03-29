
import 'package:coupons/models/shop.dart';

class Coupon {
  Coupon({
    this.id,
    this.slug,
    this.categoryId,
    this.publisherName,
    this.publisherId,
    this.publisherEmail,
    this.type,
    this.code,
    this.shopId,
    this.discountAmount,
    this.maximumUsed,
    this.url,
    this.minimumPurchaseAmount,
    this.image,
    this.pinedImage,
    this.productImage,
    this.originPrice,
    this.newPrice,
    this.startAt,
    this.endAt,
    this.totalCopied,
    this.lastCopyAt,
    this.pined,
    this.pinedAt,
    this.unpinAt,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.subscriptionId,
    this.sortNum,
    this.title,
    this.shop,
  });

  int id;
  String slug;
  int categoryId;
  String publisherName;
  int publisherId;
  String publisherEmail;
  int type;
  String code;
  int shopId;
  int discountAmount;
  int maximumUsed;
  String url;
  int minimumPurchaseAmount;
  String image;
  String productImage;
  String pinedImage;
  double originPrice;
  double newPrice;
  DateTime startAt;
  DateTime endAt;
  int totalCopied;
  DateTime lastCopyAt;
  int pined;
  DateTime pinedAt;
  DateTime unpinAt;
  int active;
  DateTime createdAt;
  DateTime updatedAt;
  int subscriptionId;
  int sortNum;
  String title;
  Shop shop;


  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["id"],
    slug: json["slug"],
    categoryId: json["category_id"],
    publisherName: json["publisher_name"],
    publisherId: json["publisher_id"],
    publisherEmail: json["publisher_email"],
    type: json["type"],
    code: json["code"],
    shopId: json["shop_id"],
    discountAmount: json["discount_amount"] == null ? 0 : int.tryParse(json["discount_amount"].toString() ?? '0'),
    maximumUsed: json["maximum_used"] == null ? null : int.tryParse(json["maximumUsed"].toString() ?? '0'),
    url: json["url"],
    minimumPurchaseAmount: json["minimum_purchase_amount"],
    image: json["image"] ?? '',
    productImage: json["product_image"] ?? json["image"] ?? null,
    pinedImage: json["pined_image"] ?? null,
    originPrice: json["origin_price"],
    newPrice: json["new_price"],
    startAt: json["start_at"] == null ? null : DateTime.parse(json["start_at"]),
    endAt: json["end_at"] == null ? null : DateTime.parse(json["end_at"]),
    totalCopied: json["total_copied"] ?? 0,
    lastCopyAt: json["last_copy_at"] == null ? null : DateTime.parse(json["last_copy_at"]),
    pined: json["pined"],
    pinedAt: json["pined_at"],
    unpinAt: json["unpin_at"] == null ? null : DateTime.parse(json["unpin_at"]),
    active: json["active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subscriptionId: json["subscription_id"] == null ? null : json["subscription_id"],
    sortNum: json["sortNum"] == null ? 0 : json["sortNum"],
    title: json["title"],
    shop: json["shop"] != null ? Shop.fromJson(json["shop"]) : new Shop(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "category_id": categoryId,
    "publisher_name": publisherName,
    "publisher_id": publisherId,
    "publisher_email": publisherEmail,
    "type": type,
    "code": code,
    "shop_id": shopId,
    "discount_amount": discountAmount ?? 0,
    "maximum_used": maximumUsed == null ? null : maximumUsed,
    "url": url,
    "minimum_purchase_amount": minimumPurchaseAmount,
    "image": image,
    "product_image": productImage,
    "origin_price": originPrice,
    "new_price": newPrice,
    "start_at": startAt == null ? null : startAt.toIso8601String(),
    "end_at": endAt == null ? null : endAt.toIso8601String(),
    "total_copied": totalCopied,
    "last_copy_at": lastCopyAt == null ? null : lastCopyAt.toIso8601String(),
    "pined": pined,
    "pined_at": pinedAt == null ? null : pinedAt.toIso8601String(),
    "unpin_at": unpinAt == null ? null : unpinAt.toIso8601String(),
    "active": active,
    "subscription_id": subscriptionId == null ? null : subscriptionId,
    "sortNum": sortNum == null ? null : sortNum,
    "title": title,
    "shop": shop != null ? shop.toJson() : null,
  };
}