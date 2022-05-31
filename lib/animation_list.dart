import 'package:flutter/material.dart';

import 'card_box.dart';
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
        )
      ]),
    );
  }
}
