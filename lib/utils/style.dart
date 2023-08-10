
import 'package:flutter/material.dart';

getBoxDecoration(
        {required Color color, required Color border, required Color shadow}) =>
    BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: border, width: 3),
      boxShadow: [
        BoxShadow(
          color: shadow.withOpacity(0.8),
          spreadRadius: 5,
          blurRadius: 10,
        ),
      ],
    );

TextStyle get boldTextStyle => const TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                    );

TextStyle get thinTextStyle => const TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.w200,
                      fontSize: 18
                    );

TextStyle get semiBoldTextStyle => const TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                    );