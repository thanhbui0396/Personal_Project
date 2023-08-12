import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';
import '../models/product_model.dart';

class CategoryProvider extends ChangeNotifier {
  Future<List<Category>> getCategory() async {
    const url = 'https://apiforlearning.zendvn.com/api/mobile/categories';
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);
      List<Category> data = List<Category>.from(jsonData
          .map((category) => Category.fromJson(jsonEncode(category)))).toList();
      return data;
    } catch (e) {
      return Future.error(Exception('NoData'));
    }
  }

  Future<List<Product>> getProductInCategory(int id) async {
    final url =
        'https://apiforlearning.zendvn.com/api/mobile/categories/$id/products';
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);

      List<Product> data = List<Product>.from(
              jsonData.map((product) => Product.fromJson(jsonEncode(product))))
          .toList();
      return data;
    } catch (e) {
      return Future.error(Exception('NoData'));
    }
  }

  
}
