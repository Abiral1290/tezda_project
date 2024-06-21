import 'dart:convert';

import '../../../api_request/http_requests.dart';
import '../model/items.dart';

class ItemsApiServices{

  Future<List<Items>> getItems() async {
    final response = await HttpRequests.requestGet('/api/v1/products');
    final  List<dynamic> jsonDecoded = json.decode(response.body);

    List<Items> items = jsonDecoded.map((dynamic item) => Items.fromJson(item as Map<String, dynamic>)).toList();
   // List items = jsonDecoded.map((dynamic item) => Items.fromJson(item)).toList();
    return items;
  }
}