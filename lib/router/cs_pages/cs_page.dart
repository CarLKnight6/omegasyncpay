import 'package:flutter/material.dart';

typedef TransitionAnimationBuilder = Widget Function(
  BuildContext,
  Animation<double>,
  Animation<double>,
  Widget,
);

///Each Screen must extend this class and provide its functionality
class CSPage<PageConfig> extends MaterialPage<PageConfig> {

  final Widget child;
  final Map<String, dynamic> args;
  

  const CSPage({
    required this.args,
    required this.child,
  }) : super(child: child, arguments: args);
}