import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ScreenLoading extends StatelessWidget {
  const ScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: const Center(
        child: SpinKitChasingDots(
          color: Colors.purple,
          size: 50.0,
        ),
      ),
    );
  }
}
