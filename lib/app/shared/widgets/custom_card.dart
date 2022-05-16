import 'package:app_pde/app/shared/utlis/constants.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final double borderRadius;
  final Color? color;
  final double elevation;

  const CustomCard({
    Key? key,
    this.padding,
    required this.child,
    this.borderRadius = Constants.defaultBorderRadius,
    this.color,
    this.elevation = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: child,
      ),
    );
  }
}