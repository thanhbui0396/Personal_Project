import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/providers/oder_provider.dart';

import '../../helper/alert.dart';

class CartPage extends StatefulWidget {
  static const routerName = '/cart';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void handleAddCart() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return alertLoading;
        }));
    Future.delayed(const Duration(seconds: 3), (() {
      Provider.of<OrderProvider>(context, listen: false)
          .buy(Provider.of<CartProvider>(context, listen: false).items)
          .then((value) => {
                if (value)
                  {
                    Navigator.pop(context),
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return alertSuccess;
                        })),
                    Provider.of<CartProvider>(context, listen: false)
                        .removeItems(),
                  }
              });
    }));
  }

  @override
  Widget build(BuildContext context) {
    var dataItems = Provider.of<CartProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng'),
      ),
      body: dataItems.isNotEmpty
          ? Stack(
              children: [
                Positioned.fill(
                  child: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      var dataItems = value.items.values.toList();
                      return ListView.separated(
                        itemCount: value.items.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image(
                                image: NetworkImage(dataItems[index].image)),
                            title: Text(
                              dataItems[index].name,
                              maxLines: 2,
                            ),
                            subtitle: Text(intl.NumberFormat.simpleCurrency(
                                    locale: 'vi', decimalDigits: 0)
                                .format(dataItems[index].price)),
                            trailing: SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Provider.of<CartProvider>(context,
                                                listen: false)
                                            .decrease(value.items.keys
                                                .toList()[index]);
                                      },
                                      child: const Icon(Icons.remove)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      '${dataItems[index].quantity}',
                                      style: const TextStyle(
                                          color: Colors.blue, fontSize: 20),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Provider.of<CartProvider>(context,
                                                listen: false)
                                            .increase(value.items.keys
                                                .toList()[index]);
                                      },
                                      child: const Icon(Icons.add)),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    child: ElevatedButton(
                      onPressed: handleAddCart,
                      child: const Text('Mua Hàng'),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Container(
                child: SvgPicture.asset('assets/images/svg/no-data.svg'),
              ),
            ),
    );
  }
}
