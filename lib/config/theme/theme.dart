import 'package:flutter/material.dart';
import 'package:testproject/features/constant/constants.dart';

ThemeData mainTheme() => ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: const Color(0xffE6E6E6),
    dialogTheme: const DialogTheme(
      alignment: Alignment.center,
      elevation: 0,
      backgroundColor: boxColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Colors.black)),
    ),
    listTileTheme: ListTileThemeData(
      titleAlignment: ListTileTitleAlignment.center,
      minVerticalPadding: 30,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(width: 1, color: Colors.black)),
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(width: 1, color: Colors.black)),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            fixedSize: const Size(300, 60))),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(width: 1, color: Colors.black)),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            fixedSize: const Size(228, 57))));
