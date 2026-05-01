import 'package:flutter_application_1/models/catalog.dart';

class CartModel {
 

  // Catalog field
  late CatalogModel _catalog;

  // Collection of IDs
  final List<int> _itemIds = [];

  // Get Catalog
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
  }

  // Get items in the cart
  List<Item> get items =>
      _itemIds
          .map((id) => CatalogModel.getById(id))
          .where((item) => item != null)
          .cast<Item>()
          .toList();

  // Total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  // Add item
  void add(Item item) {
    _itemIds.add(item.id);
  }

  // Remove item
  void remove(Item item) {
    _itemIds.remove(item.id);
  }
}