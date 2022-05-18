import 'package:flutter/material.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({Key? key, required this.title, required this.index})
      : super(key: key);

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Detail'),
      ),
      body: Container(
        child: Text('title: $title'),
      ),
    );
  }
}
