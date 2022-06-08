import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final gradient = const LinearGradient(colors: [
    Color.fromRGBO(34, 37, 41, 1),
    Color.fromRGBO(72, 80, 96, 1),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  final cardGradient = const LinearGradient(
      colors: [Color.fromRGBO(105, 108, 112, 1), Color.fromRGBO(61, 61, 68, 1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(gradient: gradient),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Hi, George',
                              style: TextStyle(
                                  color: Color.fromRGBO(105, 108, 112, 1),
                                  fontSize: 12),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Dashboard',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('images/dashboard/hero_icon.png'),
                      )
                    ],
                  ),
                  Card(
                    elevation: 10,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'images/dashboard/card.jpg',
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: Container())
                  // Positioned.fill(
                  //   child: Image.asset(
                  //     'images/dashboard/card.jpg',
                  //     fit: BoxFit.cover,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
