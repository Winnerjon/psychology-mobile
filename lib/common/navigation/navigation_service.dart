import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static int pushCount = 0;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void logOut() {}

  static BuildContext? get context => navigatorKey.currentContext;

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    context.pop(result);
  }

  static go(BuildContext context, String location, {Object? extra}) {
    context.go(location, extra: extra);
  }

  static Future<T?> push<T extends Object?>(BuildContext context, String location, {Object? extra}) async {
    return context.push(location, extra: extra);
  }

  static void pushReplacement<T extends Object?>(BuildContext context, String location, {Object? extra}) {
    return context.pushReplacement(location, extra: extra);
  }
}
