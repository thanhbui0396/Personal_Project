import 'package:flutter/material.dart';
import 'package:good_food/config/const.dart';
import 'package:flutter/services.dart';
import 'package:good_food/providers/products_providers.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/Product';
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    // TODO: implement in
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    bool change = true;
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var product =
        Provider.of<ProductProvider>(context).getItemWithId(arg['id']);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(product.image),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const Positioned(
                    top: 20,
                    left: 20,
                    child: BackButton(
                      color: dColorIconButtonInactive,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 120,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: (() {
                                  product.toggleIsFavorite();
                                  setState(() {
                                    change = !change;
                                  });
                                }),
                                child: Icon(
                                  Icons.favorite,
                                  color: product.isFavorite
                                      ? dColorIconButtonActive
                                      : dColorIconButtonInactive,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(product.favorite),
                          ],
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timelapse_sharp,
                              size: sizeIconButton,
                              color: product.isSeen
                                  ? dColorIconButtonActive
                                  : dColorIconButtonInactive,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(product.view),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                    'assets/images/background/background_product.png'),
                fit: BoxFit.cover,
              )),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(product.title),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 167,
                          height: 35,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text('Nguyên Liệu', style: styleTitleItem),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2)),
                          child: Text(product.ingredients),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 167,
                          height: 35,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          child: const Center(
                            child:
                                Text('Cách thực hiện', style: styleTitleItem),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2)),
                          child: Text(product.instructions),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
