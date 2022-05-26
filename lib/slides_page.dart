import 'package:flutter/material.dart';
import 'package:flutter_3d_card/slide_widget.dart';
import 'dart:math' as math;
import 'dots_indicator.dart';

class SlidesPage extends StatefulWidget {
  const SlidesPage({Key? key}) : super(key: key);

  @override
  State<SlidesPage> createState() => _SlidesPageState();
}

class _SlidesPageState extends State<SlidesPage> {
  final controller = PageController(initialPage: 0);

  late List<CardItem> data;
  late List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    data = List.generate(
        4,
        (index) => CardItem(
            id: index + 1,
            title: 'Card ${index + 1}',
            type: math.Random().nextInt(3) + 1,
            amount: math.Random().nextInt(10000) * 1));
    controller.addListener(() {
      // controller.page.round()
    });

    widgets = List.generate(
        3,
        (index) => SlideWidget(
            type: index + 1,
            title: 'Slide $index',
            data:
                data.where((element) => element.type == (index + 1)).toList()));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slides Page')),
      body: Stack(
        children: [
          PageView(controller: controller, children: widgets),
          Positioned(
            bottom: 30.0,
            left: 0.0,
            right: 0.0,
            child: DotsIndicator(
              controller: controller,
              itemCount: 3,
            ),
          )
        ],
      ),
    );
  }
}

class CardItem {
  int id;
  String title;
  double amount;
  int type;

  CardItem(
      {required this.id,
      required this.title,
      required this.amount,
      required this.type});
}
