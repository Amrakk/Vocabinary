import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/widgets/home/line_chart_titles.dart';

class MyLineChart extends StatefulWidget {
  const MyLineChart({super.key});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
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
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
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
            gradient: LinearGradient(
              colors: AppColors.lineChartGradient.reversed.toList(),
              stops: const [0.0, 0.5],
            ),
            dotData: const FlDotData(show: false),
            barWidth: 4,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: AppColors.lineChartInnerGradient
                    .map((color) => color.withOpacity(0.6))
                    .toList(),
                begin: Alignment.bottomRight,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
