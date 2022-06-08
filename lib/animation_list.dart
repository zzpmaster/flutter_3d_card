import 'package:flutter/material.dart';
import 'package:flutter_animation/loading_animation.dart';
import 'package:flutter_animation/tween_animation_page.dart';
import 'package:flutter_animation/dashboard.dart';

import 'card_box.dart';
import 'iIgnition.dart';
import 'nav_bar.dart';
import 'slides_page.dart';

class AnimationList extends StatelessWidget {
  const AnimationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TweenAnimationPage()));
            },
            child: const Text('Tween Animation'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const IgnitiOn()));
            },
            child: const Text('IgnitiOn'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoadingAnimation()));
            },
            child: const Text('Loading'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CardBox()));
            },
            child: const Text('3D Card'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SlidesPage()));
            },
            child: const Text('Slides'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NavBar()));
            },
            child: const Text('Nav Bar'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));
            },
            child: const Text('Dashboard'),
          ),
        )
      ]),
    );
  }
}
