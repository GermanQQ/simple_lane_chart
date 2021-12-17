library simple_lane_chart;

import 'package:flutter/material.dart';
import 'package:simple_lane_chart/untils.dart';

import 'customTooltip.dart';

class SimpleLaneChart extends StatefulWidget {
  final num firstNum;
  final num secondNum;
  final Color color;
  final Color bgColor;
  final double height;
  final bool calFrom100Perc;
  final Gradient? gradientForChart;
  final Gradient? gradientForBgChart;
  final bool tooltip;
  final bool tooltipPercent;
  final bool tooltipPreferBelow;
  final TextStyle? tooltipTextStyle;
  final Duration? animatedDuration;
  final double elevantion;

  SimpleLaneChart(this.firstNum, this.secondNum,
      {this.color = Colors.yellow,
      this.bgColor = Colors.blue,
      this.height = 8.0,
      this.calFrom100Perc = false,
      this.gradientForChart,
      this.gradientForBgChart,
      this.tooltip = false,
      this.tooltipPercent = false,
      this.tooltipPreferBelow = true,
      this.tooltipTextStyle,
      this.animatedDuration,
      this.elevantion = 3.0});

  @override
  _SimpleLaneChartState createState() => _SimpleLaneChartState();
}

class _SimpleLaneChartState extends State<SimpleLaneChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.animatedDuration ?? Duration(milliseconds: 500),
    )..forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    num firstPercent = getCorectChartSize(widget.firstNum, widget.secondNum);
    num secondPercent = getCorectChartSize(widget.secondNum, widget.firstNum);

    int sizeFirstChart = firstPercent.round();
    int sizeSecondChart = secondPercent.round();

    secondPercent = widget.calFrom100Perc ? 100 : secondPercent;

    final width = MediaQuery.of(context).size.width;
    if (width < 500) {
      sizeFirstChart = (sizeFirstChart != 0 && sizeFirstChart < 5) ? 5 : sizeFirstChart;
    } else {
      sizeFirstChart = (sizeFirstChart != 0 && sizeFirstChart < 2) ? 2 : sizeFirstChart;
    }

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Material(
            elevation: widget.elevantion,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Transform.scale(
              alignment: Alignment.centerLeft,
              scale: widget.calFrom100Perc ? 1 : _controller.value * 1,
              child: CustomTooltip(
                message: widget.tooltipPercent
                    ? '${firstPercent.toStringAsFixed(1)}% / ${secondPercent.toStringAsFixed(1)}%'
                    : '${widget.firstNum} / ${widget.secondNum}',
                visible: widget.tooltip,
                preferBelow: widget.tooltipPreferBelow,
                verticalOffset: widget.height + 2.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.bgColor,
                    gradient: widget.gradientForBgChart,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Transform.scale(
                    alignment: Alignment.centerLeft,
                    scale: widget.calFrom100Perc ? _controller.value * 1 : 1,
                    child: Row(
                      children: [
                        Flexible(
                          flex: sizeFirstChart,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: widget.height),
                            decoration: BoxDecoration(
                              color: widget.color,
                              gradient: widget.gradientForChart,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: sizeSecondChart,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: widget.height),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
