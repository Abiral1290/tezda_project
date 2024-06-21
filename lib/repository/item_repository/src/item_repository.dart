
import 'item_api_services/item_api_services.dart';
import 'model/items.dart';

class ItemRepository{

  final ItemsApiServices _itemsApiServices;

  ItemRepository({ItemsApiServices? itemApiServices}): _itemsApiServices = itemApiServices ?? ItemsApiServices();

  Future<List<Items>> getItems() async {
    final resp = await _itemsApiServices.getItems();
    return resp;
  }
}