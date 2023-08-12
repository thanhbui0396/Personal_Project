import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/pages/auth/auth_page.dart';
import 'package:shopping/pages/cart/cart.dart';
import 'package:shopping/pages/category/category.dart';
import 'package:shopping/pages/order.dart/list_order.dart';
import 'package:shopping/pages/product/product.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/providers/category_provider.dart';
import 'package:shopping/providers/oder_provider.dart';
import 'package:shopping/providers/product_provider.dart';
import 'package:shopping/providers/slider_provider.dart';

import 'pages/home/home.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SliderProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: HomePage.routerName,
          routes: {
            HomePage.routerName: (context) => const HomePage(),
            CategoryPage.routerName: (context) => const CategoryPage(),
            ProductPage.routerName: (context) => const ProductPage(),
            AuthPage.routerName: (context) => AuthPage(),
            CartPage.routerName: (context) => const CartPage(),
            ListOrder.routerName: (context) => const ListOrder(),
          },
        )),
  );
}
