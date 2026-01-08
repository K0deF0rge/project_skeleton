import 'package:flutter/material.dart';

export 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get maxHeight => MediaQuery.sizeOf(this).height;
  double get maxWidth => MediaQuery.sizeOf(this).width;
  double get paddingTop => MediaQuery.paddingOf(this).top;
  double get paddingBottom => MediaQuery.paddingOf(this).bottom;
  double get paddingLeft => MediaQuery.paddingOf(this).left;
  double get paddingRight => MediaQuery.paddingOf(this).right;

  Size get screenSize => MediaQuery.sizeOf(this);
  Orientation get orientation => MediaQuery.orientationOf(this);

  ThemeData get theme => Theme.of(this);
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  bool get isMobile => maxWidth < 600;
  bool get isTablet => maxWidth >= 600 && maxWidth < 1200;
  bool get isDesktop => maxWidth >= 1200;

  void showSnackBar(
    String text, {
    bool isError = false,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(color: isError ? Colors.white : Colors.black),
        ),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
        action: action,
        showCloseIcon: true,
        closeIconColor: isError
            ? Theme.of(this).colorScheme.onError
            : Theme.of(this).snackBarTheme.closeIconColor,
      ),
    );
  }
}
