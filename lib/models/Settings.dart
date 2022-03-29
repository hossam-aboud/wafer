import 'dart:convert';

List<SettingModel> settingModelFromJson(String str) => List<SettingModel>.from(json.decode(str).map((x) => SettingModel.fromJson(x)));

String settingModelToJson(List<SettingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SettingModel {
  SettingModel({
    this.isClose,
    this.displayAdmob,
    this.closeMessage,
    this.defaultLocale,
    this.defaultTimezone,
    this.appEmail,
    this.appName,
    this.about,
    this.defaultCurrency,
    this.instagram,
    this.telegram,
    this.facebook,
    this.twitter,
    this.whatsapp,
  });

  bool isClose;
  bool displayAdmob;
  String closeMessage;
  String defaultLocale;
  String defaultTimezone;
  String appEmail;
  String appName;
  String about;
  String defaultCurrency;
  String instagram;
  String telegram;
  String facebook;
  String twitter;
  String whatsapp;

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    isClose: json["is_close"] == null ? false : json["is_close"],
    displayAdmob: json["display_admob"] == null ? false : json["display_admob"],
    closeMessage: json["close_message"] == null ? null : json["close_message"],
    defaultLocale: json["default_locale"] == null ? null : json["default_locale"],
    defaultTimezone: json["default_timezone"] == null ? null : json["default_timezone"],
    appEmail: json["app_email"] == null ? null : json["app_email"],
    appName: json["app_name"] == null ? null : json["app_name"],
    about: json["about"] == null ? null : json["about"],
    defaultCurrency: json["default_currency"] == null ? null : json["default_currency"],
    instagram: json["instagram"] == null ? null : json["instagram"],
    telegram: json["telegram"] == null ? null : json["telegram"],
    facebook: json["facebook"] == null ? null : json["facebook"],
    twitter: json["twitter"] == null ? null : json["twitter"],
    whatsapp: json["whatsapp"] == null ? null : json["whatsapp"],
  );

  Map<String, dynamic> toJson() => {
    "is_close": isClose == null ? null : isClose,
    "display_admob": displayAdmob == null ? null : displayAdmob,
    "close_message": closeMessage == null ? null : closeMessage,
    "default_locale": defaultLocale == null ? null : defaultLocale,
    "default_timezone": defaultTimezone == null ? null : defaultTimezone,
    "app_email": appEmail == null ? null : appEmail,
    "app_name": appName == null ? null : appName,
    "about": about == null ? null : about,
    "default_currency": defaultCurrency == null ? null : defaultCurrency,
    "instagram": instagram == null ? null : instagram,
    "telegram": telegram == null ? null : telegram,
    "facebook": facebook == null ? null : facebook,
    "twitter": twitter == null ? null : twitter,
    "whatsapp": whatsapp == null ? null : whatsapp,
  };
}
