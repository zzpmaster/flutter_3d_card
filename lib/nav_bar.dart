import 'dart:ui';

import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

const _minHeight = 80.0;
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
    final mWidth = size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Nav Bar',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      backgroundColor: const Color.fromRGBO(120, 110, 239, 1),
      body: Container(),
      bottomNavigationBar: GestureDetector(
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
            final value =
                const ElasticInOutCurve(0.7).transform(_controller.value);
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
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: const Radius.circular(20),
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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
            width: size.width,
            child: Column(
              children: [
                _buildAvatar(width: 60, height: 60),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Jake Joseph',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    'Product design as a verb is to create a new product to be sold by a business to its customers.[1] A very broad coefficient and effective generation and development of ideas through a process that leads to new products.[2] Thus, it is a major aspect of new product development.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                    style: TextStyle(fontSize: 16)),
              ],
            )),
      ),
    );
  }

  Widget _buildAvatar({required double width, required double height}) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(234, 144, 145, 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      height: height,
      width: width,
      child: const Icon(
        Icons.apple,
        color: Colors.white,
      ),
    );
  }

  Widget _buildMiniContent() {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAvatar(width: 40, height: 40),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Jake Joseph',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    )),
                Text(
                  'Product Designer',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _expanded = true;
          _currentHeight = _maxHeight;
          _controller.forward(from: 0.0);
        });
      },
    );
  }
}
