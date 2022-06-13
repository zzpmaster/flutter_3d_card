import 'package:flutter/material.dart';
import 'dart:math' as math;

/// https://pin.it/4YhDQ3A
class IgnitiOn extends StatefulWidget {
  const IgnitiOn({Key? key}) : super(key: key);

  @override
  State<IgnitiOn> createState() => _IgnitiOnState();
}

class _IgnitiOnState extends State<IgnitiOn>
    with SingleTickerProviderStateMixin {
  final bubbles = List<Bubble>.generate(500, (index) {
    double size = math.Random().nextDouble() + 1.0;
    double speed = math.Random().nextDouble();
    Color color = const Color(0xFF78A9E5);
    double direction = math.Random().nextInt(180) + 180 * math.pi;

    return Bubble(
        size: size,
        speed: speed,
        color: color,
        direction: direction,
        radians: math.Random().nextDouble() * 180.0,
        position: index * 10);
  });

  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    animationController.forward();
    animationController.addStatusListener(_updateStatus);
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
      animationController.forward();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IgnitiOn')),
      backgroundColor: Color(0xFF090521),
      body: Center(
        child: Stack(
          children: [
            CustomPaint(
              foregroundPainter: BubblePainter(
                  bubbles: bubbles, animation: animationController),
              painter: OuterPainter(),
              size: Size(200, 200),
            ),
            Positioned(
              top: 30,
              left: 30,
              width: 140,
              height: 140,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
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
              (70 + 120 * animation.value * bubble.speed) *
                  math.cos(math.pi / 180 * (270 + bubble.radians)),
          size.height / 2 +
              (70 + 120 * animation.value * bubble.speed) *
                  math.sin(math.pi / 180 * (270 + bubble.radians)));
      canvas.drawCircle(offset, bubble.size, Paint()..color = bubble.color);
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
      required this.direction,
      required this.speed,
      required this.size,
      required this.position,
      required this.radians});
  final Color color;
  // 方向
  final double direction;
  final double speed;
  final double size;
  final double position;
  final double radians;
}
