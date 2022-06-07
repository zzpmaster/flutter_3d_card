import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TweenAnimationPage extends StatelessWidget {
  const TweenAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tween Animation'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: 0.0),
                      duration: const Duration(milliseconds: 500),
                      child: Image.asset(
                        'images/fargate.png',
                        height: 80,
                        width: 80,
                      ),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0.0, -200 * value),
                          child: child!,
                        );
                      },
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: 0.0),
                      duration: const Duration(milliseconds: 500),
                      child: const Text(
                        'AWS Fargate',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 24),
                      ),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(200 * value, 0.0),
                          child: child!,
                        );
                      },
                    ),
                  ],
                ),
              ),
              TweenAnimationBuilder<double>(
                curve: Curves.bounceOut,
                tween: Tween(begin: 1.0, end: 0.0),
                duration: const Duration(milliseconds: 1500),
                child: const Text(
                  'AWS Fargate is a serverless, pay-as-you-go compute engine that lets you focus on building applications without managing servers. AWS Fargate is compatible with both Amazon Elastic Container Service (ECS) and Amazon Elastic Kubernetes Service (EKS).',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0.0, 80 * value),
                    child: Opacity(
                      child: child!,
                      opacity: 1 - value,
                    ),
                  );
                },
              )
            ],
          )),
    );
  }
}
