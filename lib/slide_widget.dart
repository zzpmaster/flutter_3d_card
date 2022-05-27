import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_3d_card/slides_page.dart';

class SlideWidget extends StatefulWidget {
  SlideWidget(
      {Key? key,
      required this.title,
      required this.type,
      required this.data,
      required this.longPress,
      required this.animationController})
      : super(key: key);
  final String title;
  final int type;
  final List<CardItem> data;
  final VoidCallback longPress;
  final AnimationController animationController;
  @override
  State<SlideWidget> createState() => SlideWidgetState();
}

class SlideWidgetState extends State<SlideWidget> {
  final Color r =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 200,
      color: r,
      child: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onLongPress: () {
                // print(111);
                widget.longPress();
              },
              child: ShakeWidget(
                controller: widget.animationController,
                child: Card(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.holiday_village),
                        Text('The ${widget.data[index].title}'),
                        Text('Amount: ${widget.data[index].amount}')
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}

class ShakeWidget extends AnimatedWidget {
  ShakeWidget({required this.controller, required this.child})
      : super(listenable: controller);

  final AnimationController controller;
  final Widget child;

  final random = math.Random().nextBool() ? -1 : 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final sineValue = math.sin(math.pi * 4 * controller.value) * random;
        // return Transform.translate(
        //   offset: Offset(sineValue * 10, 0),
        //   child: child,
        // );
        return Transform.rotate(
          angle: sineValue / 150,
          child: child,
        );
      },
      child: child,
    );
  }
}
