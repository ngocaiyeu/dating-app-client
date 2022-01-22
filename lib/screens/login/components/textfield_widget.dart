import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? textController;
  final String? hintText;
  final String? labelText;
  final Icon? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? clickSuffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const TextFieldWidget({
    Key? key,
    this.hintText,
    this.textController,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.clickSuffixIcon,
    required this.obscureText,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      controller: textController,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: textController!.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  onPressed: clickSuffixIcon,
                  icon: Icon(
                    suffixIcon,
                    color: Colors.green,
                  )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green, width: 3),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
