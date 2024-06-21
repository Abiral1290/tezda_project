import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tezda_projects/ui/detail_Screen.dart';
import 'package:tezda_projects/ui/favourite_item_list.dart';
import 'package:tezda_projects/ui/item_list.dart';
import 'package:tezda_projects/ui/login_page.dart';
import 'package:tezda_projects/ui/user_register.dart';

class GeneratedRoutes {
  static const String home = "/loginPage";

  static const String registerPage = "/registerPage";
  static const String itemList = "/itemList";
  static const String itemFavouriteList = "/itemFavouriteList";



  static Route<dynamic> generatedRoutes(RouteSettings routesettings) {
    switch (routesettings.name) {
      case home:
        return MaterialPageRoute(builder: (context) =>  LoginPage());
      case registerPage:
        return MaterialPageRoute(builder: (context) =>  RegisterPage());
      case itemList:
        return MaterialPageRoute(builder: (context) =>  const ItemList());
      case itemFavouriteList:
        return MaterialPageRoute(builder: (context) =>  const FavouriteItemList());


      default:
        if (kDebugMode) {
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(child: Text('No route defined for ${routesettings.name}')),
              ));
        } else {
          return MaterialPageRoute(builder: (context) =>  LoginPage());
        }
    }
  }
}
