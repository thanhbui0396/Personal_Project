import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/pages/category/category.dart';
import 'package:shopping/providers/category_provider.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  late Future categoryFuture;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    categoryFuture = Provider.of<CategoryProvider>(context).getCategory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categoryFuture,
      initialData: const [],
      builder: (context, asynData) {
        var categoryData = [];
        if (asynData.hasData) {
          categoryData = asynData.data! as List;
        } else {
          return Container(
            child: const Text('erro'),
          );
        }
        return SizedBox(
          height: 80,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            itemCount: categoryData.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 37,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CategoryPage.routerName,
                      arguments: {
                        'id': categoryData[index].id,
                        'name': categoryData[index].name
                      });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        boxShadow: const [],
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            categoryData[index].image,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                      child: Text(
                        categoryData[index].name,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
