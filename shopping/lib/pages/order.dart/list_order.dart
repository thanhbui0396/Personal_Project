import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/providers/oder_provider.dart';
import 'package:shopping/providers/product_provider.dart';

class ListOrder extends StatefulWidget {
  static const routerName = '/listOder';
  const ListOrder({Key? key}) : super(key: key);

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  // final bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách đơn hàng'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrderProvider>(context).getListOderCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var data = snapshot.data as List;

          return snapshot.hasData
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dataItems = data[index]['order_items'] as List;
                    return ExpansionTile(
                      title: Text('Mã đơn hàng: ${data[index]['code']}'),
                      subtitle: Text(DateFormat('kk:mm - dd-MM-yyyy ')
                          .format(DateTime.parse(data[index]['created_at']))),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: dataItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return FutureBuilder(
                                future: Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .getProductById(
                                  dataItems[index]['product_id'],
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  var item = snapshot.data as Product;
                                  return ListTile(
                                    leading: Image.network(item.image),
                                    title: Text(item.name),
                                  );
                                });
                          },
                        ),
                      ],
                    );
                  },
                )
              : Center(
                  child: SvgPicture.asset('assets/images/svg/no-data.svg'),
                );
        },
      ),
    );
  }
}
