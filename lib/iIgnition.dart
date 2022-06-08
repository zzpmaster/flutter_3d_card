import 'package:flutter/material.dart';
import 'dart:math' as math;

class IgnitiOn extends StatefulWidget {
  const IgnitiOn({Key? key}) : super(key: key);

  @override
  State<IgnitiOn> createState() => _IgnitiOnState();
}

class _IgnitiOnState extends State<IgnitiOn>
    with SingleTickerProviderStateMixin {
  final bubbles = List<Bubble>.generate(500, (index) {
    double size = math.Random().nextInt(10) + 2.0;
    double speed = math.Random().nextInt(50) + 1.0;
    Color color = const Color(0xFF78A9E5);
    double direction = math.Random().nextInt(180) + 180 * math.pi;

    return Bubble(
        size: size,
        speed: speed,
        color: color,
        direction: direction,
        position: index * 10);
  });

  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
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
                    shape: BoxShape.circle, color: Color(0xFF090521)),
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
          size.width / 2 + bubble.direction * animation.value,
          size.height * (1 - animation.value) -
              bubble.speed * animation.value +
              bubble.position * (1 - animation.value));
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
      required this.position});
  final Color color;
  // 方向
  final double direction;
  final double speed;
  final double size;
  final double position;
}
