import 'package:flutter/material.dart';
import 'package:good_food/config/const.dart';
import 'package:good_food/page/home/widget/category.dart';
import 'package:good_food/providers/category_providers.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CategoryProviders().readJson(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var categoryItem = snapshot.hasData ? snapshot.data : [];

          return Scaffold(
            appBar: AppBar(
              backgroundColor: dColorMain,
              title: const Text('Good Food'),
            ),
            body: snapshot.hasData
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: categoryItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          //cách 1
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: ((context) => CategoryPage(title: index))));

                          //cách 2
                          // Navigator.pushNamed(context, '/category',
                          //     arguments: {"title": index});

                          //cách 3
                          Navigator.pushNamed(context, CategoryPage.routeName,
                              arguments: {
                                "title": categoryItem[index].name,
                                "categoryId": categoryItem[index].id
                              });
                        },
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage(categoryItem[index].image),
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    categoryItem[index].name.toString(),
                                    style: styleTitleItem,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('No Data'),
                  ),
          );
        });
  }
}
