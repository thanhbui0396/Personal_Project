import 'dart:convert';

import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Products extends ChangeNotifier {
  String id;
  String categoryId;
  String title;
  String image;
  String intro;
  String ingredients;
  String instructions;
  String view;
  String favorite;
  bool isFavorite = false;
  bool isSeen = false;
  Products({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.image,
    required this.intro,
    required this.ingredients,
    required this.instructions,
    required this.view,
    required this.favorite,
  });

  void toggleIsFavorite() {
    isFavorite = !isFavorite;
    favorite = isFavorite
        ? (int.parse(favorite) + 1).toString()
        : (int.parse(favorite) - 1).toString();
    notifyListeners();
  }

  void handleRemoveFavorite() {
    isFavorite = false;
    favorite = (int.parse(favorite) - 1).toString();
  }

  void handleRemoveSeen() {
    isSeen = false;
    view = (int.parse(view) - 1).toString();
  }

  void toggleIsSeen() {
    if (isSeen == false) {
      isSeen = true;
      view = (int.parse(view) + 1).toString();
      notifyListeners();
    } else {
      isSeen = isSeen;
      notifyListeners();
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'image': image,
      'intro': intro,
      'ingredients': ingredients,
      'instructions': instructions,
      'view': view,
      'favorite': favorite,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'] as String,
      categoryId: map['categoryId'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
      intro: map['intro'] as String,
      ingredients: map['ingredients'] as String,
      instructions: map['instructions'] as String,
      view: map['view'] as String,
      favorite: map['favorite'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source) as Map<String, dynamic>);
}
