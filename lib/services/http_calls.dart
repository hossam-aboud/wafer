import 'dart:convert';

import 'package:coupons/global/tokens.dart';
import 'package:coupons/global/url.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class Request {
  final String url;
  final dynamic body;

  Request({this.url, this.body});

  Future<http.Response> post({tokenRequired = false}) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'C_P_TOKEN': c_p_token,
      'lang': Get.locale.languageCode

    };
    if(tokenRequired) {
      String token = GetStorage().read('password');
      headers.addAll({"Authorization": "Bearer $token"});
    }
    http.Response res = await http.post(Uri.tryParse(urlBase + url), body: jsonEncode(body), headers: headers).timeout(Duration(minutes: 2));
    print("============================================================= [POST : $url]  BODY : ${res.body}");
    return res;
  }

  Future<http.Response> get({tokenRequired = false}) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'C_P_TOKEN': c_p_token,
      'lang': Get.locale.languageCode
    };
    if(tokenRequired) {
      String token = GetStorage().read('password');
      headers.addAll({"Authorization": "Bearer $token"});
    }
    return http.get(Uri.tryParse(urlBase + url), headers: headers).timeout(Duration(minutes: 1));
  }

  Future<http.Response> delete(String model, int id) async {
    String token = GetStorage().read('password');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    Map<String, dynamic> data = {
      'name': model,
      'id': id.toString()
    };
    return http.post(Uri.tryParse(urlBase + 'delete'), body: data, headers: headers).timeout(Duration(minutes: 2));
  }
}