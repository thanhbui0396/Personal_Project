import 'package:flutter/material.dart';
import 'package:good_food/config/const.dart';
import 'package:good_food/providers/products_providers.dart';
import 'package:provider/provider.dart';

class SeenBody extends StatelessWidget {
  const SeenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemsSeen = Provider.of<ProductProvider>(context).getItemsIsSeen();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dColorMain,
        title: const Text('Seen'),
        actions: (itemsSeen.isNotEmpty)
            ? <Widget>[
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    print('delete favorite');
                  },
                ),
              ]
            : [],
      ),
      body: itemsSeen.isNotEmpty
          ? ListView.builder(
              itemCount: itemsSeen.length,
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ChangeNotifierProvider.value(
                  value: itemsSeen[index],
                  child: Dismissible(
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('delete Item'),
                            content: const Text('Are you sure delete?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                      onDismissed: (direction) {
                        itemsSeen[index].handleRemoveSeen();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Delete Success!'),
                        ));
                      },
                      key: ValueKey<int>(index),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 140,
                          child: GridTile(
                            footer: GridTileBar(
                              title: Text(
                                itemsSeen[index].title,
                                style: styleTitleItem,
                              ),
                              trailing: const Icon(
                                Icons.swipe,
                                size: sizeIconButton,
                                color: dColorIconButtonInactive,
                              ),
                              backgroundColor: dColorFooterImage,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 140,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(itemsSeen[index].image),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      )),
                );
              },
            )
          : const Center(
              child: Text('No Data'),
            ),
    );
  }
}
