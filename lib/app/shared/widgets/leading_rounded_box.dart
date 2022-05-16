import 'package:app_pde/app/shared/utlis/constants.dart';
import 'package:flutter/material.dart';

class LeadingRoundedBox extends StatelessWidget {
  final String text;
  final Color color;

  const LeadingRoundedBox({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          Constants.defaultBorderRadius / 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
