import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BorderedAttachmentBox extends StatelessWidget {
  final String? labelText;
  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback? closeCallback;
  final bool hasCloseButton;
  final double width;
  final double height;

  const BorderedAttachmentBox({
    Key? key,
    this.labelText,
    required this.icon,
    required this.onTap,
    this.hasCloseButton = false,
    this.closeCallback,
    this.height = 50,
    this.width = 70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            InkWell(
              splashColor: AppColors.primaryLight,
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(8),
                width: width,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: AppColors.primary),
                    const SizedBox(height: 2),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (labelText != null)
              SizedBox(
                width: 80,
                child: Text(
                  labelText!,
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        if (hasCloseButton)
          Positioned(
            right: -6,
            top: -6,
            child: GestureDetector(
              onTap: closeCallback,
              child: Container(
                height: 20,
                width: 20,
                color: Colors.white,
                child: const Icon(
                  MdiIcons.closeCircle,
                  size: 20,
                  color: AppColors.error,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
