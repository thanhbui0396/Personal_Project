import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/providers/product_provider.dart';
import 'package:intl/intl.dart' as intl;

class ListProductSpecial extends StatelessWidget {
  const ListProductSpecial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ProductProvider>(context).getProductSpecial(),
      initialData: const [],
      builder: (context, asynData) {
        if (asynData.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        var data = asynData.data!;
        return asynData.hasData
            ? Expanded(
                flex: 1,
                child: ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image(
                        image: NetworkImage(data[index].image),
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        data[index].name,
                        maxLines: 2,
                      ),
                      subtitle: Text(intl.NumberFormat.simpleCurrency(
                              locale: 'vi', decimalDigits: 0)
                          .format(data[index].price)),
                      trailing: InkWell(
                          onTap: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .addCart(data[index].id, data[index].name,
                                    data[index].image, data[index].price);
                          },
                          child: const Icon(Icons.shopping_cart_checkout)),
                    );
                  },
                ),
              )
            : const Center(
                child: Text('Empty Product'),
              );
      },
    );
  }
}
