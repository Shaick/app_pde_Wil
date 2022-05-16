import 'package:flutter/material.dart';

class CustomLoadButton extends StatefulWidget {
  final bool loading;
  final Function onPressed;
  final String title;
  final double? width;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  final Color? color;
  final double? height;

  const CustomLoadButton({
    Key? key,
    required this.loading,
    required this.onPressed,
    required this.title,
    this.width,
    this.textStyle,
    this.style,
    this.color,
    this.height = 46,
  }) : super(key: key);
  @override
  _CustomLoadButtonState createState() => _CustomLoadButtonState();
}

class _CustomLoadButtonState extends State<CustomLoadButton> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: widget.height,
      width: width > 600 ? width * .3 : width,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        style: widget.style,
        onPressed: widget.loading
            ? () {}
            : () {
                setState(() {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  currentFocus.unfocus();
                  widget.onPressed();
                });
              },
        child: widget.loading
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ))
            : Text(
                widget.title.toUpperCase(),
                style: widget.textStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
              ),
      ),
    );
  }
}
