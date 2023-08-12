import 'package:flutter/material.dart';
import 'package:good_food/models/products.dart';
import 'package:provider/provider.dart';

import '../../../config/const.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Products>(context, listen: false);
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: dColorFooterImage,
          title: Text(
            product.title,
            style: styleTitleItem,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<Products>(builder: (((context, value, child) {
                return Row(
                  children: [
                    InkWell(
                        onTap: (() {
                          value.toggleIsFavorite();
                        }),
                        child: Icon(
                          Icons.favorite,
                          size: sizeIconButton,
                          color: value.isFavorite
                              ? dColorIconButtonActive
                              : dColorIconButtonInactive,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      value.favorite,
                      style: styleTitleIcon,
                    ),
                  ],
                );
              }))),
              const SizedBox(
                width: 10,
              ),
              Consumer<Products>(
                builder: (((context, value, child) {
                  return Row(
                    children: [
                      Icon(
                        Icons.timelapse_sharp,
                        size: sizeIconButton,
                        color: value.isSeen
                            ? dColorIconButtonActive
                            : dColorIconButtonInactive,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        value.view,
                        style: styleTitleIcon,
                      )
                    ],
                  );
                })),
              ),
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            product.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
