// ignore_for_file: file_names

import 'package:ecommerceapp/components/constants.dart';
import 'package:ecommerceapp/constants/app_styling.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration decoration;
  final FontWeight? weight;
  final TextOverflow? textOverflow;
  final Color? color;
  final Color? decorationColor;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;

  final int? maxLines;
  final double? size;
  final double? lineHeight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingBottom;
  final double? letterSpacing;

  CustomText({
    Key? key,
    required this.text,
    this.size,
    this.lineHeight,
    this.maxLines,
    this.decoration = TextDecoration.none,
    this.color,
    this.letterSpacing,
    this.weight = FontWeight.w400,
    this.textAlign,
    this.textOverflow,
    this.fontFamily,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
    this.paddingBottom = 0,
    this.onTap,
    this.fontStyle,
    this.decorationColor = kblackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: only(
        context,
        top: paddingTop!,
        left: paddingLeft!,
        right: paddingRight!,
        bottom: paddingBottom!,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          "$text",
          style: TextStyle(
            fontSize: f(context, size!),
            color: color ?? kblackColor,
            fontWeight: weight,
            decoration: decoration,
            decorationColor: decorationColor,
            height: lineHeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: textOverflow,
        ),
      ),
    );
  }
}
