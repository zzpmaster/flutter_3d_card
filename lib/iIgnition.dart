import 'package:flutter/material.dart';
import 'dart:math' as math;

/// https://pin.it/4YhDQ3A
class IgnitiOn extends StatefulWidget {
  const IgnitiOn({Key? key}) : super(key: key);

  @override
  State<IgnitiOn> createState() => _IgnitiOnState();
}

class _IgnitiOnState extends State<IgnitiOn> with TickerProviderStateMixin {
  final bubbles = List<List<Bubble>>.generate(
      4,
      (index) => List<Bubble>.generate(300, (index) {
            double size = math.Random().nextDouble() + 1.0;
            double speed = math.Random().nextDouble();
            Color color = const Color(0xFF78A9E5);

            return Bubble(
                size: size,
                speed: speed,
                color: color,
                radians: math.Random().nextDouble() * 180.0);
          }));
  late final List<AnimationController> controllers;
  late final AnimationController animationController1;
  late final AnimationController animationController2;

  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() async {
    controllers = List.generate(
        4,
        (index) => AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 1000),
            ));
    for (var controller in controllers) {
      await Future.delayed(const Duration(milliseconds: 300));
      controller.repeat();
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IgnitiOn')),
      backgroundColor: const Color(0xFF090521),
      body: Center(
        child: Stack(
          children: [
            ...List.generate(
                bubbles.length,
                (index) => CustomPaint(
                      foregroundPainter: BubblePainter(
                          bubbles: bubbles[index],
                          animation: controllers[index]),
                      painter: OuterPainter(),
                      size: const Size(200, 200),
                    )).toList(),
            // ),
            Positioned(
              top: 30,
              left: 30,
              width: 140,
              height: 140,
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF090521)),
                //Color(0xFF090521)
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter({required this.bubbles, required this.animation})
      : super(repaint: animation);

  final List<Bubble> bubbles;
  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    for (Bubble bubble in bubbles) {
      final offset = Offset(
          size.width / 2 +
              (65 + 200 * animation.value * bubble.speed) *
                  math.cos(math.pi / 180 * (270 + bubble.radians)),
          size.height / 2 +
              (65 + 200 * animation.value * bubble.speed) *
                  math.sin(math.pi / 180 * (270 + bubble.radians)));
      late Color color;
      if (animation.value == 0) {
        color = bubble.color.withOpacity(0);
      } else if (animation.value >= 0.6) {
        color = bubble.color.withOpacity(1 - animation.value);
      } else {
        color = bubble.color;
      }
      canvas.drawCircle(offset, bubble.size, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class OuterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 60.0
      ..style = PaintingStyle.stroke
      ..color = Colors.white;

    double degToRad(double deg) => deg * (math.pi / 360);

    final path = Path()
      ..arcTo(
          Rect.fromCenter(
            center: Offset(size.height / 2, size.width / 2),
            height: size.height,
            width: size.width,
          ),
          degToRad(180),
          degToRad(360),
          false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Bubble {
  Bubble(
      {required this.color,
      required this.speed,
      required this.size,
      required this.radians});
  final Color color;
  // 速度
  final double speed;
  final double size;
  final double radians;
}
