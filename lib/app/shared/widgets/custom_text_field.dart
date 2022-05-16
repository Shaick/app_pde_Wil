import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/utlis/constants.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String) validator;
  final void Function(String)? onChanged;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool enabled;
  final TextInputFormatter? maskFormatter;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final Color? color;

  const CustomTextField({
    Key? key,
    required this.label,
    this.hint,
    this.controller,
    required this.validator,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.streetAddress,
    this.enabled = true,
    this.maskFormatter,
    this.maxLines = 1,
    this.textInputAction,
    this.color,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: widget.color,
      width: width > 600 ? width * .3 : width,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        enabled: widget.enabled,
        validator: (value) => widget.validator(value ?? ''),
        textAlign: widget.textAlign,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        decoration: new InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(Constants.defaultBorderRadius),
          ),
          suffixIcon: widget.suffixIcon,
          labelText: widget.label,
          hintText: widget.hint,
          errorStyle: const TextStyle(color: AppColors.error),
          hintStyle: const TextStyle(color: AppColors.grey),
          labelStyle: const TextStyle(color: AppColors.grey),
        ),
        onChanged: widget.onChanged,
        inputFormatters:
            widget.maskFormatter != null ? [widget.maskFormatter!] : null,
        maxLines: widget.maxLines,
        textInputAction: widget.textInputAction,
      ),
    );
  }
}
