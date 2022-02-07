library simple_lane_chart;

import 'package:flutter/material.dart';
import 'package:simple_lane_chart/untils.dart';

import 'customTooltip.dart';

class SimpleLaneChart extends StatefulWidget {
  ///First number which you want to compare.
  ///Is required variable
  final num firstNum;

  ///Second number which you want to compare with first number.
  ///If you choose [calFrom100Perc] value "true", this shoud be total sum value of first and second num
  ///Is required variable
  final num secondNum;

  ///Color
  final Color color;

  ///Color second chart or background
  final Color bgColor;

  ///Height of chart
  final double height;

  ///For progres chart, if you chose [calFrom100Perc] value "true", [secondNum] shoud be total sum
  final bool calFrom100Perc;

  ///Gradient first chart
  final Gradient? gradientForChart;

  ///Gradient second chart or background
  final Gradient? gradientForBgChart;

  ///Visuble tooltip
  final bool tooltip;

  ///Show percent compare between 2 value
  final bool tooltipPercent;

  ///Below tooltip
  final bool tooltipPreferBelow;

  ///Text style for tooltip
  final TextStyle? tooltipTextStyle;

  ///Visuble text count
  final bool showTextCount;

  ///Text style for text count
  final TextStyle? textStyle;

  ///Alignment text count
  final Alignment? aligmentText;

  ///Show text count in percent
  final bool textPercent;

  ///Animated duration
  final Duration? animatedDuration;

  ///Elevantion for chart
  final double elevantion;

  SimpleLaneChart(this.firstNum, this.secondNum,
      {this.color = Colors.deepOrange,
      this.bgColor = Colors.indigo,
      this.height = 15.0,
      this.calFrom100Perc = false,
      this.gradientForChart,
      this.gradientForBgChart,
      this.tooltip = true,
      this.tooltipPercent = true,
      this.textPercent = false,
      this.tooltipPreferBelow = false,
      this.showTextCount = true,
      this.tooltipTextStyle,
      this.textStyle,
      this.aligmentText,
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
    num firstPercent = widget.calFrom100Perc
        ? (widget.firstNum / widget.secondNum) * 100
        : getCorectChartSize(widget.firstNum, widget.secondNum);
    num secondPercent =
        widget.calFrom100Perc ? 100 - firstPercent : getCorectChartSize(widget.secondNum, widget.firstNum);

    int sizeFirstChart = firstPercent.round();
    int sizeSecondChart = secondPercent.round();

    final width = MediaQuery.of(context).size.width;
    if (width < 500) {
      sizeFirstChart = (sizeFirstChart != 0 && sizeFirstChart < 5) ? 5 : sizeFirstChart;
    } else {
      sizeFirstChart = (sizeFirstChart != 0 && sizeFirstChart < 2) ? 2 : sizeFirstChart;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTooltip(
          message: widget.tooltipPercent
              ? '${firstPercent.toStringAsFixed(1)}% / ${widget.calFrom100Perc ? 100.0 : secondPercent.toStringAsFixed(1)}%'
              : '${widget.firstNum} / ${widget.secondNum}',
          visible: widget.tooltip,
          preferBelow: widget.tooltipPreferBelow,
          verticalOffset: (widget.height / 2) + 2,
          child: Container(
            height: widget.height,
            child: AnimatedBuilder(
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
                  );
                }),
          ),
        ),
        if (widget.showTextCount)
          Align(
            alignment: widget.aligmentText ?? Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget.textPercent
                    ? '${firstPercent.toStringAsFixed(1)}% / ${widget.calFrom100Perc ? 100.0 : secondPercent.toStringAsFixed(1)}%'
                    : '${widget.firstNum} / ${widget.secondNum}',
                style: widget.textStyle ??
                    TextStyle(
                      fontSize: 16,
                      fontFamily: 'Helvetica',
                    ),
              ),
            ),
          ),
      ],
    );
  }
}
