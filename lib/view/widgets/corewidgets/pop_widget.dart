import 'package:flutter/material.dart';

class PopScopeWidget extends StatelessWidget {
  final Widget widget;
  final void Function(bool, Object?) func;

  const PopScopeWidget({super.key,  required this.func , required this.widget,});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: func,
      child: widget,
    );
  }
}
