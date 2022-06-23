import 'dart:ui';

import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

const _minHeight = 100.0;
const _maxHeight = 220.0;

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  final gradient = const LinearGradient(colors: [
    Color.fromRGBO(34, 37, 41, 1),
    Color.fromRGBO(72, 80, 96, 1),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  final cardGradient = const LinearGradient(
      colors: [Color.fromRGBO(105, 108, 112, 1), Color.fromRGBO(61, 61, 68, 1)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  final controller = PageController(initialPage: 0);

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const Positioned.fill(
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
                  // balance card
                  BalanceCard(
                    size: size,
                    controller: animationController,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BalanceCard extends StatefulWidget {
  const BalanceCard({Key? key, required this.size, required this.controller})
      : super(key: key);

  final Size size;
  final AnimationController controller;

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  double _currentHeight = _maxHeight;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          final newHeight = _currentHeight - details.delta.dy;
          widget.controller.value = _currentHeight / _maxHeight;
          _currentHeight = newHeight.clamp(_minHeight, _maxHeight);
        });
      },
      onVerticalDragEnd: (details) {
        if (_currentHeight < _maxHeight / 2) {
          widget.controller.reverse();
          setState(() {
            // _expanded = false;
          });
        } else {
          widget.controller.forward(from: 1 - _currentHeight / _maxHeight);
          setState(() {
            // _expanded = true;
            _currentHeight = _maxHeight;
          });
        }
      },
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (BuildContext context, Widget? child) {
          // final value = const ElasticInOutCurve(0.7)
          //     .transform(widget.controller.value);
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(50, 53, 58, 0.9),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                height: 220,
                width: widget.size.width,
                child: Padding(
                  child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                          sigmaX: 3 * widget.controller.value,
                          sigmaY: 3 * widget.controller.value),
                      child: Image.asset(
                        'images/img4.png',
                        fit: BoxFit.contain,
                      )),
                  padding: const EdgeInsets.all(16.0),
                ),
              ),
              Positioned(
                height: lerpDouble(
                    _minHeight, _currentHeight, widget.controller.value),
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(75, 77, 83, 0.98),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(children: [
                        Container(
                          height: 5,
                          width: 36,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                        Opacity(
                          opacity: widget.controller.value,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF33373C),
                                        borderRadius: BorderRadius.circular(8)),
                                    height: 36,
                                    width: 36,
                                    child: Image.asset(
                                      'images/icons8-image.png',
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text('ATM, 375 Canal St',
                                            style: TextStyle(
                                                color: Color(0xFFCCCED1),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text('Cash withdrawal',
                                            style: TextStyle(
                                                color: Color(0xFFCCCED1),
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12))
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    '- \$300',
                                    style: TextStyle(
                                        color: Color(0xFFCCCED1),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
