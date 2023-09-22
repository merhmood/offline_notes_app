import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offline_notes/icons/back.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        elevation: MaterialStatePropertyAll(0),
      ),
      onPressed: () => context.go('/'),
      child: const BackIcon(),
    );
  }
}
