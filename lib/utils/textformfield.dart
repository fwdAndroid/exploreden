import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hintText;
  final TextStyle? hintStyle;
  final TextInputType textInputType;
  final Widget? preIcon;
  final Widget? suIcon;

  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator? validat;
  final List<TextInputFormatter>? inputFormatters;
  final String? error;
  final int? maxLines;

  const TextFormInputField(
      {Key? key,
      required this.controller,
      this.isPass = false,
      this.preIcon,
      this.suIcon,
      this.onFieldSubmitted,
      this.hintStyle,
      this.onChanged,
      this.error,
      this.maxLines,
      this.onTap,
      this.autovalidateMode,
      this.inputFormatters,
      this.validat,
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: const [
          BoxShadow(blurRadius: 0.2, spreadRadius: 0.5, color: Colors.grey)
        ],
        color: colorWhite,
      ),
      margin: const EdgeInsets.only(left: 15, right: 15),
      width: 335,
      height: 65,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        maxLines: maxLines,
        onTap: onTap,
        autovalidateMode: autovalidateMode,
        inputFormatters: inputFormatters,
        validator: validat,
        onChanged: onChanged,
        keyboardType: textInputType,
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: suIcon,
            prefixIcon: preIcon,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorWhite),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorWhite),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorWhite),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            border: InputBorder.none,
            fillColor: colorWhite,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: colorBlack)),
      ),
    );
  }
}
