import 'package:flutter/material.dart';
import 'package:flutter_animation/slide_widget.dart';
import 'dart:math' as math;
import 'dots_indicator.dart';

class SlidesPage extends StatefulWidget {
  const SlidesPage({Key? key}) : super(key: key);

  @override
  State<SlidesPage> createState() => _SlidesPageState();
}

class _SlidesPageState extends State<SlidesPage>
    with SingleTickerProviderStateMixin {
  final controller = PageController(initialPage: 0);

  late List<CardItem> data;
  // late List<Widget> widgets;

  late final AnimationController animationController;
  bool editButton = false;
  bool dragEnable = false;

  Future<void> _onLongPress() async {
    if (editButton) {
      return;
    }
    setState(() {
      dragEnable = true;
    });
    shake();
  }

  @override
  void initState() {
    super.initState();
    initAnimation();
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
  }

  void initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    animationController.addStatusListener(_updateStatus);
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
      animationController.forward();
    }
  }

  void shake() {
    setState(() {
      editButton = true;
    });
    animationController.forward();
  }

  void stop() {
    setState(() {
      editButton = false;
    });
    animationController.reset();
    animationController.stop();
  }

  @override
  void dispose() {
    stop();
    controller.dispose();
    animationController.dispose();
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slides Page'),
        actions: [
          Visibility(
            visible: editButton,
            child: IconButton(
              onPressed: () {
                stop();
                setState(() {
                  dragEnable = false;
                });
              },
              icon: const Icon(
                Icons.done,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          PageView(
              controller: controller,
              children: List.generate(
                  3,
                  (index) => SlideWidget(
                      animationController: animationController,
                      longPress: _onLongPress,
                      type: index + 1,
                      title: 'Slide $index',
                      dragEnable: dragEnable,
                      data: data
                          .where((element) => element.type == (index + 1))
                          .toList()))),
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
