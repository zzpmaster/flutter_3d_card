import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  int counter = 0;
  int old = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading'),
      ),
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          // curve: Curves.linear,
          key: Key(counter.toString()),
          duration: const Duration(milliseconds: 700),
          builder: (context, value, child) {
            return Stack(
              children: [
                // if (old != -1)
                Transform.translate(
                  offset: Offset(0.0, (1 - value) * 40),
                  child: Opacity(
                    opacity: value,
                    child: Text(
                      '$counter',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 30),
                    ),
                  ),
                ),
                if (old != -1)
                  Transform.translate(
                    offset: Offset(0.0, -40 * value),
                    child: Opacity(
                      child: child!,
                      opacity: 1 - value,
                    ),
                  )
              ],
            );
          },
          child: Text(
            '$old',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: () {
            old = counter;
            setState(() {
              counter = counter + 1;
            });
          }),
    );
  }
}

class ProgressCounter extends StatelessWidget {
  const ProgressCounter({Key? key, required this.value}) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${(value * 100).truncate()}',
      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
    );
  }
}
