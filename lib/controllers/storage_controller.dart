import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class StorageController {
  static final _getStorage = GetStorage();


  static List<dynamic> getStorageAsList(keyName) {
    String value = _getStorage.read(keyName);
    if(value == null) {
      return null;
    } else {
      List<dynamic> valueAsMap = jsonDecode(value);
      return valueAsMap;
    }
  }

  static getStorageAsListDynamic(keyName) {
    String value = _getStorage.read(keyName);
    if(value == null) {
      return null;
    } else {
      List<dynamic> valueAsMap = jsonDecode(value);
      return valueAsMap;
    }
  }


  static void saveStorageAsListMap(keyName,List<Map<String, dynamic>> value) {
    String valueAsString = value == null ? null : jsonEncode(value);
    _getStorage.write(keyName, valueAsString);
  }

  static void saveStorageAsList(keyName,List<dynamic> value) {
    String valueAsString = jsonEncode(value);
    _getStorage.write(keyName, valueAsString);
  }

  static saveStorage(keyName, dynamic value) {
    _getStorage.write(keyName, value);
  }

  static void deleteStorage(keyName) {
    _getStorage.remove(keyName);
  }
}