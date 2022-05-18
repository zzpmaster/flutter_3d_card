import 'package:flutter/material.dart';

class CardBox extends StatelessWidget {
  const CardBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 3, child: CardsBody()),
        Expanded(
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

class _CardsBodyState extends State<CardsBody>
    with SingleTickerProviderStateMixin {
  // double _value = 0.15;
  bool _selectedMode = false;
  late AnimationController _animationController;
  late int selectedIndex;

  Future<void> _onCardSelected(String title, int index) async {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.15,
        upperBound: 0.5,
        duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                absorbing: _selectedMode,
                child: Container(
                  // color: Colors.white,
                  width: constraints.maxWidth * 0.45,
                  height: constraints.maxHeight,
                  child: Stack(
                    children: [
                      ...List.generate(
                          4,
                          (index) => CardItem(
                              height: constraints.maxHeight / 2,
                              title: 'Card $index',
                              percent: selectionValue,
                              onSelected: (title) {
                                _onCardSelected(title, index);
                              },
                              depth: index)).reversed,
                      // Positioned(
                      //   bottom: 0,
                      //   left: 0,
                      //   right: 0,
                      //   child: Slider(
                      //     value: _value,
                      //     min: 0.15,
                      //     max: 0.5,
                      //     onChanged: (v) {
                      //       setState(() {
                      //         _value = v;
                      //       });
                      //     },
                      //   ),
                      // )
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

class CardItem extends StatelessWidget {
  const CardItem(
      {Key? key,
      required this.title,
      required this.height,
      required this.depth,
      required this.onSelected,
      required this.percent})
      : super(key: key);

  final double height;
  final double percent;
  final String title;
  final int depth;
  final double depthFactor = 50;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final bottomMargin = height / 4.0;
    return Positioned(
      left: 0,
      right: 0,
      top: height + -depth * height / 2.0 * percent - bottomMargin,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translate(0.0, 0.0, depth * depthFactor),
        child: InkWell(
          onTap: () {
            // print('touch');
            onSelected(title);
          },
          child: SizedBox(
            height: height,
            child: CardWidget(title: title),
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
                child: CardWidget(
                  title: 'Card $index',
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
          width: 200,
          height: 30,
          color: const Color(0xff4D40E4),
        ),
      ),
    );
  }
}
