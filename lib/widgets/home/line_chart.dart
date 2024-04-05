import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'line_chart_titles.dart';


class MyLineChart extends StatefulWidget {
  const MyLineChart({super.key,});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  final _gardientColors = [
    const Color(0xff3c8ce7),
    const Color(0xff000000),
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 3,
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    return LineTooltipItem(
                      touchedSpot.y.toString(),
                      const TextStyle(color: Colors.red),
                    );
                  }).toList();
                },
              ),
            ),
            titlesData:  const FlTitlesData(
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: ChartTitles.bottomTitleWidgets,
                  interval: 1,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: ChartTitles.leftTitleWidgets,
                  interval: 1,
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 0),
                  const FlSpot(1, 1),
                  const FlSpot(2, 1.5),
                  const FlSpot(3, 1.4),
                  const FlSpot(4, 3),
                  const FlSpot(5, 2),
                  const FlSpot(6, 2.5),
                ],
                isCurved: true,
                color: Colors.blue,
                gradient: const LinearGradient(
                  colors: [Colors.blue, Color(0xff5efce8)],
                  stops: [0.0, 0.5],
                ),
                dotData: const FlDotData(show: false),
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  gradient:  LinearGradient(
                    colors: _gardientColors
                        .map((color) => color.withOpacity(0.6)).toList(),
                    begin: Alignment.bottomRight,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ]
        )
    );
  }
}