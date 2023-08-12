import 'package:flutter/material.dart';
import 'package:good_food/config/const.dart';
import 'package:good_food/page/favorites/favorites_body.dart';
import 'package:good_food/page/home/home_body.dart';
import 'package:good_food/page/seen/seen_body.dart';
import 'package:good_food/providers/products_providers.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  late Future _dataFuture;
  static const List<Widget> widgetOptions = <Widget>[
    HomeBody(),
    FavoritesBody(),
    SeenBody(),
  ];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _dataFuture = Provider.of<ProductProvider>(context).readJson();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _dataFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
            // appBar: AppBar(
            //   backgroundColor: dColorMain,
            //   title: const Text('Good Food'),
            // ),
            body: widgetOptions[selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.timelapse_sharp),
                  label: 'Seen',
                ),
              ],
              currentIndex: selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: dColorMain,
              iconSize: sizeIconButton,
              unselectedItemColor: dColorIconButtonInactive,
              selectedItemColor: dColorIconButtonActive,
            ),
          );
        });
  }
}
