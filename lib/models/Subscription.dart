import 'dart:convert';

List<Subscription> subscriptionFromJson(String str) => List<Subscription>.from(json.decode(str).map((x) => Subscription.fromJson(x)));

String subscriptionToJson(List<Subscription> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subscription {
  Subscription({
    this.id,
    this.price,
    this.currency,
    this.daysPeriod,
    this.name,
    this.text,
  });

  int id;
  int price;
  String currency;
  int daysPeriod;
  String name;
  String text;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["id"] == null ? null : json["id"],
    price: json["price"] == null ? null : json["price"],
    currency: json["currency"] == null ? null : json["currency"],
    daysPeriod: json["days_period"] == null ? null : json["days_period"],
    name: json["name"] == null ? null : json["name"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "price": price == null ? null : price,
    "currency": currency == null ? null : currency,
    "days_period": daysPeriod == null ? null : daysPeriod,
    "name": name == null ? null : name,
    "text": text == null ? null : text,
  };
}
