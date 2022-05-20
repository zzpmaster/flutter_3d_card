import 'package:flutter/material.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({Key? key, required this.title, required this.index})
      : super(key: key);

  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(15.0);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Card Detail',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 10),
          child: Hero(
            tag: title,
            child: PhysicalModel(
              color: Colors.black,
              borderRadius: border,
              elevation: 10,
              child: ClipRRect(
                borderRadius: border,
                // child: Container(
                //   padding: const EdgeInsets.only(left: 10, top: 8),
                //   child: Text(
                //     title,
                //     style: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600),
                //   ),
                //   width: constraints.maxWidth * 0.85,
                //   height: constraints.maxHeight * 0.25,
                //   color: const Color(0xff4D40E4),
                // ),
                child: Image.asset(
                  'images/img${index + 1}.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
