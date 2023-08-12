import 'package:flutter/material.dart';
import 'package:good_food/models/products.dart';
import 'package:good_food/page/home/widget/category_body.dart';
import 'package:good_food/page/home/widget/product.dart';
import 'package:good_food/providers/products_providers.dart';
import 'package:provider/provider.dart';

import '../../../config/const.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/category';
  const CategoryPage({
    Key? key,
  }) : super(key: key);
  // final title;

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    var products = Provider.of<ProductProvider>(context)
        .getItemsWithCategoryId(data['categoryId']);

    return Scaffold(
      appBar: AppBar(
        title: Text(data['title']),
        backgroundColor: dColorMain,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: (() {
                products[index].toggleIsSeen();
                Navigator.pushNamed(context, ProductPage.routeName, arguments: {
                  "id": products[index].id,
                });
              }),
              child: ChangeNotifierProvider<Products>.value(
                value: products[index],
                child: const CategoryBody(),
              ));
        },
      ),
    );
  }
}
