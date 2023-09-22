import 'package:flutter/material.dart';

class SaveIcon extends StatelessWidget {
  const SaveIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.0,
      height: 70.0,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Color.fromRGBO(59, 59, 59, 1)),
        child: Image.asset(
          'assets/save.png',
          scale: 0.9,
        ),
      ),
    );
  }
}
