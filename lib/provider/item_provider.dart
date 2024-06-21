import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tezda_projects/controller/preference_controller.dart';
import 'package:tezda_projects/repository/item_repository/src/item_repository.dart';
import 'package:tezda_projects/repository/item_repository/src/model/items.dart';

class ItemProvider extends ChangeNotifier{


  final ItemRepository _itemRepository = ItemRepository();

  List<Items>? item ;
  List<bool> myBool = [];


  bool myBoolean(bool myBoolean,int index){
    notifyListeners();
    myBool[index] =myBoolean;
    return myBool[index];

  }
  Future<void> fetchItems() async {
    Map<String, dynamic> query = {};

    try {
      _itemRepository.getItems().then((value) {

        item = value;
        for(int i = 0; i < item!.length; i++){
          myBool.add(false);
        }


        log("values $value");
        notifyListeners();
      });
    } catch (e) {
      //
    }
  }
}

class FavouriteItemProvider extends ChangeNotifier{


  bool favourite = false;
  List<Items>? items ;

  late PreferenceController preferenceController;

  Future<void> fetchFavouriteItems() async {
  //  Map<String, dynamic> query = {};
    notifyListeners();
    try {
      log("my items $items");
      items=

          PreferenceController.sharedPreferences.getStringList("userId")!
    .map((itemJson) => Items.fromJson(jsonDecode(itemJson))).toList();
      log("my items $items");
    } catch (e) {
      //
    }
  }



}