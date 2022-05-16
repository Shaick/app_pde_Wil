import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:flutter/material.dart';

class CustomInfoMapItem extends StatelessWidget {
  final MapEntry<String, dynamic> e;

  const CustomInfoMapItem(this.e, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.key,
            style: const TextStyle(color: AppColors.grey, fontSize: 16),
          ),
          const SizedBox(height: 2),
          Container(
            child: Text(
              e.value,
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
      )
    );
  }
}
