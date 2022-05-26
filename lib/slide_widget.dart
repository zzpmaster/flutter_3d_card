import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_3d_card/slides_page.dart';

class SlideWidget extends StatefulWidget {
  SlideWidget(
      {Key? key, required this.title, required this.type, required this.data})
      : super(key: key);
  final String title;
  final int type;
  final List<CardItem> data;
  @override
  State<SlideWidget> createState() => SlideWidgetState();
}

class SlideWidgetState extends State<SlideWidget> {
  final Color r =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

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
                print(111);
              },
              child: ShakeWidget(
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.album),
                    title: Text('The ${widget.data[index].title}'),
                    subtitle: Text('Amount: ${widget.data[index].amount}'),
                  ),
                ),
              ),
            );
          })),
    );
  }
}

class ShakeWidget extends StatefulWidget {
  ShakeWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    animationController.addStatusListener(_updateStatus);
    shake();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
      animationController.forward();
    }
  }

  void shake() {
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final sineValue = math.sin(math.pi * 4 * animationController.value);
        // return Transform(
        //   // offset: Offset(sineValue * 10, 0),
        //   transform: Matrix4.identity()..setRotationY(100 * sineValue),
        //   child: child,
        // );
        // return Transform.translate(
        //   offset: Offset(sineValue * 10, 0),
        //   // transform: Matrix4.identity()..setRotationY(100 * sineValue),
        //   child: child,
        // );
        return Transform.rotate(
          angle: sineValue / 50,
          // transform: Matrix4.identity()..setRotationY(100 * sineValue),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
