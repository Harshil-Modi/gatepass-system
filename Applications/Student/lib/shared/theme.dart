// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:gatepassStudent/shared/const.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ThemeButton extends RaisedButton {
  String text;
  @required
  Function() onPressed;
  BuildContext context;
  ThemeButton({
    @required this.text,
    @required this.onPressed,
    this.context,
  }) : super(
          shape: shapeRounded,
          child: Text(
            text.toUpperCase(),
            style: themeButtonTextStyle,
          ),
          onPressed: onPressed,
          color: Colors.blue,
          textColor: Colors.white,
        );
}

// ignore: must_be_immutable
class ThemeButtonWidth extends Container {
  final double width;
  String text;
  Function() onPressed;
  BuildContext context;

  ThemeButtonWidth({
    this.width = buttonWidth,
    this.context,
    @required this.onPressed,
    @required this.text,
  }) : super(
          width: width,
          child: ThemeButton(
            context: context,
            onPressed: onPressed,
            text: text,
          ),
        );
}

void showSnackBar({
  @required BuildContext context,
  @required Widget content,
  SnackBarAction action,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: content,
      action: action,
    ),
  );
}

class ThemeAppBar extends AppBar {
  ThemeAppBar({@required String title})
      : super(
          title: Text(
            title,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
            ),
          ),
        );
}
