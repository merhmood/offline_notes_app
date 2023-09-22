import 'package:flutter/material.dart';

class DeleteIcon extends StatelessWidget {
  const DeleteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.0,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Color.fromRGBO(255, 0, 0, 1)),
      child: Image.asset('assets/Vector.png'),
    );
  }
}
