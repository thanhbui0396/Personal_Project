import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/pages/auth/auth_page.dart';
import 'package:shopping/pages/cart/cart.dart';
import 'package:shopping/pages/home/widget/home_category.dart';
import 'package:shopping/pages/home/widget/home_slider.dart';
import 'package:shopping/pages/home/widget/list_product_special.dart';
import 'package:shopping/pages/order.dart/list_order.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopping/providers/cart_provider.dart';

class HomePage extends StatelessWidget {
  static const routerName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      return auth.isAuth
          ? const Home()
          : FutureBuilder(
              future: auth.autoLogin(),
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return snapshot.data ? const Home() : AuthPage();
              });
    });
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<AuthProvider>(context).checkTimeExpires();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              const SizedBox(
                child: Image(image: AssetImage('assets/images/logo.png')),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('Trang chủ'),
                        onTap: () {
                          // Navigator.pushNamed(context, HomePage.routerName);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.library_books),
                        title: const Text('Danh sách đơn hàng'),
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, ListOrder.routerName);
                        },
                      ),
                      ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Đăng xuất'),
                          onTap: () {
                            Provider.of<AuthProvider>(context, listen: false)
                                .logout();
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 15),
            child: Consumer<CartProvider>(
              builder: (context, value, child) {
                return badges.Badge(
                  badgeContent: Text('${value.items.length}'),
                  position: badges.BadgePosition.topEnd(top: -12),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CartPage.routerName);
                    },
                    child: const Icon(Icons.shopping_cart),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: const Column(
        children: [
          HomeSlider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              height: 17,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Danh mục sản phẩm',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tất cả (4)',
                    style: TextStyle(fontSize: 9),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          HomeCategory(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: SizedBox(
              height: 17,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sản phẩm đặc biệt',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tất cả (4)',
                    style: TextStyle(fontSize: 9),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListProductSpecial(),
        ],
      ),
    );
  }
}
