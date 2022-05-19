import 'package:flutter/material.dart';

import 'card_detail.dart';

class CardBox extends StatelessWidget {
  const CardBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 3, child: CardsBody()),
        const Expanded(
          flex: 1,
          child: CardsHorizontal(),
        ),
      ],
    );
  }
}

class CardsBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CardsBodyState();
  }
}

class _CardsBodyState extends State<CardsBody> with TickerProviderStateMixin {
  // double _value = 0.15;
  bool _selectedMode = false;
  late AnimationController _animationController;
  late AnimationController _animationMoveController;
  int? selectedIndex;

  Future<void> _onCardSelected(String title, int index) async {
    setState(() {
      selectedIndex = index;
    });
    const duration = Duration(milliseconds: 750);
    _animationMoveController.forward();
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: duration,
        reverseTransitionDuration: duration,
        pageBuilder: ((context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: CardDetail(
              title: title,
              index: index,
            ),
          );
        }),
      ),
    );
    _animationMoveController.reverse(from: 1.0);
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.2,
        upperBound: 0.45,
        duration: const Duration(milliseconds: 500));

    _animationMoveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationMoveController.dispose();
    super.dispose();
  }

  int _getCurrentFactor(int currentIndex) {
    if (selectedIndex == null || selectedIndex == currentIndex) {
      return 0;
    } else if (selectedIndex! > currentIndex) {
      return 1;
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, snapshot) {
          final selectionValue = _animationController.value;
          return GestureDetector(
            onTap: () {
              if (!_selectedMode) {
                _animationController.forward().whenComplete(() {
                  setState(() {
                    _selectedMode = !_selectedMode;
                  });
                });
              } else {
                _animationController.reverse().whenComplete(() {
                  setState(() {
                    _selectedMode = !_selectedMode;
                  });
                });
              }
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(selectionValue),
              child: AbsorbPointer(
                absorbing: !_selectedMode,
                child: Container(
                  color: Colors.red,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Stack(
                    // clipBehavior: Clip.none,
                    children: [
                      ...List.generate(
                        4,
                        (index) => CardItem(
                            width: constraints.maxWidth * 0.75,
                            height: constraints.maxHeight / 2,
                            title: 'Card $index',
                            percent: selectionValue,
                            onSelected: (title) {
                              _onCardSelected(title, index);
                            },
                            vfactor: _getCurrentFactor(index),
                            animation: _animationMoveController,
                            depth: index),
                      ).reversed,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }));
  }
}

// class CardItem extends StatelessWidget {
class CardItem extends AnimatedWidget {
  const CardItem(
      {Key? key,
      required this.title,
      required this.width,
      required this.height,
      required this.depth,
      required this.onSelected,
      required this.percent,
      this.vfactor = 0,
      required Animation<double> animation})
      : super(key: key, listenable: animation);

  final double width;
  final double height;
  final double percent;
  final String title;
  final int depth;
  final double depthFactor = 50;
  final ValueChanged<String> onSelected;
  final int vfactor;
  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final bottomMargin = height / 4.0;
    return Positioned.fill(
      left: 0,
      right: 0,
      // top: height + -depth * height / 2.0 * percent - bottomMargin,
      top: height + -depth * height / 2.0 * percent,
      child: Opacity(
        opacity: vfactor == 0 ? 1 : 1 - animation.value,
        child: Hero(
          tag: title,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..translate(
                  0.0,
                  vfactor *
                      animation.value *
                      MediaQuery.of(context).size.height,
                  depth * depthFactor),
            child: GestureDetector(
              onTap: () {
                onSelected(title);
              },
              child: SizedBox(
                width: 50,
                height: height,
                child: CardWidget(title: title),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardsHorizontal extends StatelessWidget {
  const CardsHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text('Horizontal Cards'),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 200,
                  height: 30,
                  child: CardWidget(
                    title: 'Card $index',
                  ),
                ),
              );
            },
            itemCount: 4,
          ),
        )
      ],
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(15.0);
    return PhysicalModel(
      color: Colors.black,
      borderRadius: border,
      elevation: 10,
      child: ClipRRect(
        borderRadius: border,
        child: Container(
          padding: const EdgeInsets.only(left: 10, top: 8),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          color: const Color(0xff4D40E4),
        ),
      ),
    );
  }
}
