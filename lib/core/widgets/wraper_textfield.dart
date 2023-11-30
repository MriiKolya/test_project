import 'package:flutter/material.dart';
import 'package:testproject/features/constant/constants.dart';

class WraperTextFormField extends StatelessWidget {
  const WraperTextFormField({
    super.key,
    required this.textEditingController,
    this.validator,
    this.height,
    this.width,
    this.keyboardType,
  });

  final TextEditingController textEditingController;
  final String? Function(String? value)? validator;
  final double? height;
  final double? width;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? 160,
      child: TextFormField(
        keyboardType: keyboardType,
        validator: validator,
        controller: textEditingController,
        style: Theme.of(context).textTheme.labelLarge,
        decoration: const InputDecoration(
            filled: true,
            isDense: true,
            fillColor: backgroundTextField,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none),
      ),
    );
  }
}
