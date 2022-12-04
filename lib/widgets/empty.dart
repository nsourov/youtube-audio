import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class EmptyPlayer extends StatelessWidget {
  const EmptyPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Lottie.asset(
        'assets/lottie.json',
        repeat: false,
      ),
    );
  }
}
