import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezda_projects/repository/item_repository/src/model/items.dart';

import '../utilities/constants.dart';



class PreferenceController {
  static late SharedPreferences sharedPreferences;
  String userId = 'userId';
  List<Items> item=[];

  static Future<void> init() async => sharedPreferences = await SharedPreferences.getInstance();


  /// shared preference set methods
  static Future<bool> setBool(String key, bool value) async =>
      await sharedPreferences.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async =>
      await sharedPreferences.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async =>
      await sharedPreferences.setInt(key, value);

  static Future<bool> setString(String key, String value) async =>
      await sharedPreferences.setString(key, value);

  static Future<bool> setStringList(String key, List<Items> value) async =>
      await sharedPreferences.setStringList(key, value.cast<String>());

  Future<void> saveItems(Items items) async {

    item.add(items);
    log("my json init ${item}");
    List<String> itemsJson = item.map((item) => jsonEncode(item.toJson())).toList();
    log("my json ${itemsJson.toString()}");
    await sharedPreferences.setStringList(userId, itemsJson);
    log("my json ${sharedPreferences.getStringList(userId)}");

  }

   List<Items> getItems() {
    List<String>? itemsJson = sharedPreferences.getStringList(userId);

    log("my items $itemsJson");
    if (itemsJson == null) {
      return [];
    }
    return itemsJson.map((itemJson) => Items.fromJson(jsonDecode(itemJson))).toList();
  }

  delete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(Constants.userLoggedIn);

  }
}
