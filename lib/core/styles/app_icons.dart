import 'package:flutter/material.dart';

class AppIcons {
  static Widget name(BuildContext context, {Color? color, double? size}) =>
      Icon(
        Icons.account_circle_outlined,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        size: size ?? 24,
      );
  static Widget email(BuildContext context, {Color? color, double? size}) =>
      Icon(
        Icons.email_outlined,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        size: size ?? 24,
      );
  static Widget password(BuildContext context, {Color? color, double? size}) =>
      Icon(
        Icons.password_outlined,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        size: size ?? 24,
      );

  static Widget viewPassword(
    BuildContext context, {
    required bool canViewPassword,
    Color? color,
    double? size,
  }) => Icon(
    !canViewPassword ? Icons.lock_rounded : Icons.lock_open_outlined,
    color: color ?? Theme.of(context).colorScheme.onSurface,
    size: size ?? 24,
  );
}
