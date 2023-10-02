import 'package:flutter/material.dart';

class Categorycard extends StatelessWidget {
  const Categorycard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.red),
    );
  }
}
