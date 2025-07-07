import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final double top;
  final double left;
  final Color iconColor;
  final Color backgroundColor;
  final double iconSize;

  final VoidCallback? onPressed;

  const BackButtonWidget({
    super.key,
    this.top = 10.0,
    this.left = 16.0,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.black54,
    this.iconSize = 30.0,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: iconColor,
          iconSize: iconSize,
          onPressed: onPressed ?? () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
