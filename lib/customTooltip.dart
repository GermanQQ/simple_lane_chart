import 'package:flutter/material.dart';

class CustomTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final bool visible;
  final bool preferBelow;
  final double verticalOffset;
  final TextStyle? textStyle;

  CustomTooltip({
    required this.message,
    required this.child,
    required this.verticalOffset,
    required this.preferBelow,
    this.textStyle,
    this.visible = false,
  });

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      message: visible ? message : "",
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      textStyle:
          textStyle ?? TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
      decoration: visible ? null : BoxDecoration(color: Colors.transparent),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
