import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_food/models/products.dart';

class ProductProvider extends ChangeNotifier {
  List<Products> _items = [];
  List<Products> get items => [..._items];

  List<Products> getItemsWithCategoryId(categoryId) {
    return _items.where((element) => element.categoryId == categoryId).toList();
  }

  Products getItemWithId(id) {
    return _items.singleWhere((element) => element.id == id);
  }

  List<Products> getItemsIsFavorite() {
    return _items.where((element) => element.isFavorite).toList();
  }

  List<Products> getItemsIsSeen() {
    return _items.where((element) => element.isSeen).toList();
  }


  Future<List<Products>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/product.json');
    final dataDecode = await json.decode(response);
    List<Products> data = List<Products>.from(
        dataDecode.map((i) => Products.fromJson(jsonEncode(i))));
    _items = data;
    return data;
  }
}
