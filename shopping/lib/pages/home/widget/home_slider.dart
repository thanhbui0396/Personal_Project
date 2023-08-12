import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/slider_provider.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  late Future sliderFuture;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    sliderFuture = Provider.of<SliderProvider>(context).getSlider();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      child: FutureBuilder(
        future: sliderFuture,
        initialData: const [],
        builder: (context, asynData) {
          var sliderData = [];
          if (asynData.hasData) {
            sliderData = asynData.data! as List;
          } else {
            return Container(
              child: const Text('erro'),
            );
          }

          return asynData.hasData
              ? CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 131.0,
                    autoPlay: true,
                  ),
                  items: sliderData.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(13)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(i.image))),
                        );
                      },
                    );
                  }).toList(),
                )
              : const Center(
                  child: Text('No Data'),
                );
        },
      ),
    );
  }
}
