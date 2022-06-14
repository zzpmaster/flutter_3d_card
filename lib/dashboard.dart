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
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            // decoration: BoxDecoration(gradient: gradient),
            decoration: BoxDecoration(color: Color(0xFF26292E)),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Hi, George',
                                style: TextStyle(
                                    color: Color.fromRGBO(105, 108, 112, 1),
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Dashboard',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
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
                  ),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: Image.asset(
                          'images/dashboard/card.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Positioned(
                        top: 30,
                        left: 20,
                        child: Text(
                          'Monitor your ',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      const Positioned(
                        top: 55,
                        left: 20,
                        child: Text(
                          'expenses',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      Positioned(
                          bottom: 20,
                          left: 20,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(64, 26)),
                              onPressed: () {},
                              child: const Text('Get')))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(50, 53, 58, 0.9),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        // height: 200,
                        width: size.width,
                        child: Padding(
                          child: Image.asset('images/img4.png'),
                          padding: const EdgeInsets.all(20.0),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(50, 53, 58, 0.98),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        // height: 200,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(children: [
                            Container(
                              height: 5,
                              width: 36,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Color(0xFF6E7478),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Balance',
                                  style: TextStyle(color: Color(0xFF87888F)),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(64, 20),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'See more',
                                      style: TextStyle(fontSize: 8),
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/icon-dollar.png',
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                const Text(
                                  '6,421.52',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 24),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  '23 March',
                                  style: TextStyle(color: Color(0xFF87888F)),
                                ),
                                Text(
                                  '- \$813',
                                  style: TextStyle(color: Color(0xFF87888F)),
                                ),
                              ],
                            )
                          ]),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
