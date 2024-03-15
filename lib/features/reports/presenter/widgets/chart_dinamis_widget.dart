import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/config/theme.dart';

class ChartDinamisWidget extends StatelessWidget {
  ChartDinamisWidget({
    super.key,
    this.minX = 0,
    this.minY = 0,
    this.bottomTitles = const AxisTitles(
      sideTitles: SideTitles(
        reservedSize: 30,
        showTitles: true,
      ),
    ),
    this.leftTitles = const AxisTitles(
      sideTitles: SideTitles(
        reservedSize: 44,
        showTitles: true,
      ),
    ),
    required this.maxX,
    required this.maxY,
    required this.spots,
  });

  final AxisTitles leftTitles;
  final AxisTitles bottomTitles;
  final double minX;
  final double minY;
  final double maxX;
  final double maxY;
  final List<FlSpot> spots;
  final List<Color> gradientColors = [
    MyTheme.primary,
    const Color.fromARGB(255, 201, 123, 27),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: bottomTitles,
              leftTitles: leftTitles,
            ),
            borderData: FlBorderData(
              show: false,
            ),
            minX: minX,
            maxX: maxX,
            minY: minY,
            maxY: maxY + 10000,
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                gradient: LinearGradient(
                  colors: gradientColors,
                ),
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: const FlDotData(
                  show: true,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
