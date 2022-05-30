import 'dart:ui';

import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

const _minHeight = 70.0;
const _maxHeight = 350.0;

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _expanded = false;
  double _currentHeight = _minHeight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mWidth = size.width * 0.5;
    return Scaffold(
      appBar: AppBar(title: const Text('Nav Bar')),
      body: Container(),
      bottomNavigationBar: GestureDetector(
        // onTap: () {
        //   setState(() {
        //     _expanded = !_expanded;
        //   });
        //   if (_expanded) {
        //     _controller.forward();
        //   } else {
        //     _controller.reverse();
        //   }
        // },
        onVerticalDragUpdate: _expanded
            ? (details) {
                setState(() {
                  final newHeight = _currentHeight - details.delta.dy;
                  _controller.value = _currentHeight / _maxHeight;
                  _currentHeight = newHeight.clamp(_minHeight, _maxHeight);
                });
              }
            : null,
        onVerticalDragEnd: _expanded
            ? (details) {
                if (_currentHeight < _maxHeight / 2) {
                  _controller.reverse();
                  setState(() {
                    _expanded = false;
                  });
                } else {
                  _controller.forward(from: _currentHeight / _maxHeight);
                  setState(() {
                    _expanded = true;
                    _currentHeight = _maxHeight;
                  });
                }
              }
            : null,
        child: AnimatedBuilder(
          animation: _controller,
          builder: ((context, child) {
            // final value = _controller.value;
            // final value = Curves.elasticInOut.transform(_controller.value);
            final value = ElasticInOutCurve(0.7).transform(_controller.value);
            return Stack(
              children: [
                Positioned(
                  // height: lerpDouble(_minHeight, _maxHeight, value),
                  height: lerpDouble(_minHeight, _currentHeight, value),
                  left: lerpDouble((size.width - mWidth) / 2, 0, value),
                  width: lerpDouble(mWidth, size.width, value),
                  bottom: lerpDouble(40, 0, value),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(lerpDouble(20, 0, value)!),
                      ),
                    ),
                    child: _expanded
                        ? Opacity(
                            opacity: _controller.value,
                            child: _buildContent(),
                          )
                        : _buildMiniContent(),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Column(
              children: [
                Text('Title'),
                Text('Content'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMiniContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.apple,
          color: Colors.white,
        ),
        GestureDetector(
          child: Icon(
            Icons.apple,
            color: Colors.white,
          ),
          onTap: () {
            setState(() {
              _expanded = true;
              _currentHeight = _maxHeight;
              _controller.forward(from: 0.0);
            });
          },
        ),
        Icon(
          Icons.apple,
          color: Colors.white,
        ),
      ],
    );
  }
}
