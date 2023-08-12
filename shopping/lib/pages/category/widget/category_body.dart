import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/pages/product/product.dart';
import 'package:shopping/providers/category_provider.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({Key? key}) : super(key: key);

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  late Future productInCategoryFuture;

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    productInCategoryFuture =
        Provider.of<CategoryProvider>(context).getProductInCategory(arg['id']);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productInCategoryFuture,
      initialData: const [],
      builder: (context, asynData) {
        List productData = [];
        if (asynData.hasData) {
          productData = asynData.data as List;
        } else {
          return Container(
            child: const Text('erro'),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 4,
          ),
          itemCount: productData.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, ProductPage.routerName,
                    arguments: {
                      'data': productData[index],
                    });
              },
              child: GridTile(
                footer: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(20)),
                  child: GridTileBar(
                    backgroundColor: Colors.black45,
                    title: Text(productData[index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productData[index].summary),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          productData[index].price.toString(),
                          style: const TextStyle(
                              color: Colors.yellow, fontSize: 16),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.shopping_cart),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(productData[index].image),
                          fit: BoxFit.cover)),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
