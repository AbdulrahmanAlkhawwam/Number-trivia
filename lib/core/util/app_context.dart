import 'package:flutter/material.dart';

extension AppTheme on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension AppResponsive on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;

  double get width => MediaQuery.sizeOf(this).width;

  Orientation get deviceMode => MediaQuery.orientationOf(this);

  /// bottom padding from the system, includes system nav bar
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;

  /// bottom insets from the system, includes keyboard height
  double get bottomInsets => MediaQuery.viewInsetsOf(this).bottom;
}

extension AppSnackbar on BuildContext {
  void showSuccessSnackBar({String? massage}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: colors.primary,
            width: 3,
          ),
        ),
        duration: const Duration(seconds: 2),
        content: Text(
          massage ?? "Success",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: massage == null ? 20 : 14,
            fontWeight: massage == null ? FontWeight.bold : FontWeight.w600,
          ),
        ),
        backgroundColor: colors.primaryContainer,
      ),
    );
  }

  void showErrorSnackBar({String? massage}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: colors.error,
            width: 3,
          ),
        ),
        duration: const Duration(seconds: 2),
        content: Text(
          massage ?? "Error",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: massage == null ? 20 : 14,
            fontWeight: massage == null ? FontWeight.bold : FontWeight.w600,
          ),
        ),
        backgroundColor: colors.errorContainer,
      ),
    );
  }
}
