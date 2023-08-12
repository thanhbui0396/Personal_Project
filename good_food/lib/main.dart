import 'package:flutter/material.dart';
import 'package:good_food/page/home/widget/category.dart';
import 'package:good_food/page/home/widget/product.dart';
import 'package:good_food/providers/category_providers.dart';
import 'package:good_food/providers/products_providers.dart';
import 'package:provider/provider.dart';

import 'page/index.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CategoryProviders()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //initialRoute: màn hình mặc định khi vào app
          initialRoute: '/',
          //routes: đặt tên cho màn hình
          routes: {
            '/': ((contex) => const MyApp()),
            // '/category': ((contex) => const CategoryPage()),
            CategoryPage.routeName: ((contex) => const CategoryPage()),
            ProductPage.routeName: ((contex) => const ProductPage()),
          },
        )),
  );
}
