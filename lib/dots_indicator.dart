import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  const DotsIndicator(
      {Key? key,
      required this.controller,
      required this.itemCount,
      this.color = Colors.white})
      : super(key: key, listenable: controller);

  final PageController controller;
  final int itemCount;
  final Color color;

  static const double _dotSize = 8.0;
  static const double _dotBox = 32;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => buildDoc(index),
      ),
    );
  }

  Widget buildDoc(int index) {
    double offset = Curves.linear.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_dotBox / _dotSize - 1.0) * offset;
    return SizedBox(
        width: _dotBox,
        height: _dotBox,
        child: Center(
          child: Material(
              color: color,
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: _dotSize * zoom,
                height: _dotSize,
              )),
        ));
  }
}
