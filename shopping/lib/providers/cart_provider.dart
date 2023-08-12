// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CartItem {
  final int id;
  final String name;
  final String image;
  final int price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });
}

class CartProvider extends ChangeNotifier {
  Map<int, CartItem> items = {};
  void addCart(int idProduct, String name, String image, int price,
      [int quantity = 1]) {
    if (items.containsKey(idProduct)) {
      items.update(
          idProduct,
          (value) => CartItem(
                id: value.id,
                name: value.name,
                image: value.image,
                price: value.price,
                quantity: value.quantity + quantity,
              ));
    } else {
      items.putIfAbsent(
          idProduct,
          () => CartItem(
              id: idProduct,
              name: name,
              image: image,
              price: price,
              quantity: quantity));
    }
    notifyListeners();
  }

  void increase(int idProduct, [int quantity = 1]) {
    items.update(
        idProduct,
        (value) => CartItem(
              id: value.id,
              name: value.name,
              image: value.image,
              price: value.price,
              quantity: value.quantity + quantity,
            ));
    notifyListeners();
  }

  void decrease(int idProduct, [int quantity = 1]) {
    if (items[idProduct]?.quantity == quantity) {
      items.removeWhere((key, value) => key == idProduct);
    } else {
      items.update(
          idProduct,
          (value) => CartItem(
                id: value.id,
                name: value.name,
                image: value.image,
                price: value.price,
                quantity: value.quantity - quantity,
              ));
    }
    notifyListeners();
  }

  void removeItems() {
    items = {};
    notifyListeners();
  }
}
