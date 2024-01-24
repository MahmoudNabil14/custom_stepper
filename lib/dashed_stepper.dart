library dashed_stepper;

import 'package:flutter/material.dart';

class DashedStepper extends StatelessWidget {
  const DashedStepper({
    super.key,
    this.steps = 3,
    this.currentStep = 0,
    this.icons,
    this.height,
    this.labelStyle,
    this.indicatorColor,
    this.disabledColor,
    this.lineHeight,
    this.dotSize,
    required this.activeWidget,
    required this.inActiveWidget,
    required this.finishedWidget,
  }) : assert((icons == null || icons.length == steps),
            'icons length must be the same as length');

  final int steps;
  final int currentStep;
  final List<Widget>? icons;
  final double? height;
  final TextStyle? labelStyle;
  final Color? indicatorColor;
  final Color? disabledColor;
  final double? lineHeight;
  final double? dotSize;
  final Widget activeWidget;
  final Widget inActiveWidget;
  final Widget finishedWidget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          steps,
          (index) {
            return Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icons != null)
                    Container(
                      height: height ?? 40,
                      alignment: Alignment.topCenter,
                      child: icons![index],
                    ),
                  _HorizStep(
                    dotSize: dotSize,
                    height: lineHeight,
                    activeColor: indicatorColor,
                    inActiveColor: disabledColor,
                    stepLinesWidth: size.maxWidth / steps,
                    left: index < currentStep,
                    right: index < currentStep - 1,
                    roundedLeft: index == 0
                        ? true
                        : index < currentStep
                            ? false
                            : true,
                    roundedRight: index == steps - 1
                        ? true
                        : index < currentStep - 1
                            ? false
                            : true,
                    activeWidget: activeWidget,
                    inActiveWidget: inActiveWidget,
                    finishedWidget: finishedWidget,
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}

class _HorizStep extends StatelessWidget {
  const _HorizStep({
    this.left = false,
    this.right = false,
    this.stepLinesWidth = 100,
    this.roundedLeft = true,
    this.roundedRight = true,
    this.activeColor,
    this.inActiveColor,
    this.height,
    this.dotSize,
    required this.activeWidget,
    required this.inActiveWidget,
    required this.finishedWidget,
  });

  final bool left;
  final bool right;
  final double stepLinesWidth;
  final bool roundedLeft;
  final bool roundedRight;
  final Color? activeColor;
  final Widget activeWidget;
  final Widget inActiveWidget;
  final Widget finishedWidget;
  final Color? inActiveColor;
  final double? height;
  final double? dotSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Line(
              width: stepLinesWidth / 2,
              isActive: left,
              roundedLeft: roundedLeft,
              color: activeColor,
              disabledColor: inActiveColor,
              height: height,
            ),
            _Line(
              width: stepLinesWidth / 4,
              isActive: right,
              roundedRight: roundedRight,
              color: activeColor,
              disabledColor: inActiveColor,
              height: height,
            ),
          ],
        ),
        if (left == true && right == false)
          activeWidget
        else if (left && right)
          finishedWidget
        else
          inActiveWidget
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    this.width = 10,
    this.color,
    this.height,
    this.disabledColor,
    this.isActive = true,
    this.roundedLeft = true,
    this.roundedRight = true,
  });

  final double width;
  final double? height;
  final Color? color;
  final Color? disabledColor;
  final bool isActive;
  final bool roundedLeft;
  final bool roundedRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: roundedLeft ? const Radius.circular(50) : Radius.zero,
          right: roundedRight ? const Radius.circular(50) : Radius.zero,
        ),
        color: isActive ? color : disabledColor,
      ),
    );
  }
}
