import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocabinary/utils/dimensions.dart';

import 'Indicator.dart';

int touchedIndex = -1;

class MyPieChart extends StatefulWidget {
  const MyPieChart({super.key});

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}
class _MyPieChartState extends State<MyPieChart> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: Dimensions.widthSize(context, 50),
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 55,
              sectionsSpace:  10,
              pieTouchData: PieTouchData(
                touchCallback: (event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse
                        .touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              sections: showingSections(),
            ),
          ),
        ),
        const SizedBox(width: 28),
        const Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Indicator(
              color: Color(0xff0293ee),
              text: 'Easy',
              isSquare: true,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: Color(0xfff8b250),
              text: 'Normal',
              isSquare: true,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: Color(0xff845bef),
              text: 'Hard',
              isSquare: true,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: Color(0xff13d38e),
              text: 'Ultimate',
              isSquare: true,
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> data = [
  {
    'color': const Color(0xff0293ee),
    'value': 40,
    'title': '40%',
  },
  {
    'color': const Color(0xfff8b250),
    'value': 30,
    'title': '30%',
  },
  {
    'color': const Color(0xff845bef),
    'value': 15,
    'title': '15%',
  },
  {
    'color': const Color(0xff13d38e),
    'value': 15,
    'title': '15%',
  },
];

List<PieChartSectionData> showingSections() {
  return List.generate(4, (i) {
    final isTouched = i == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 60.0 : 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    return PieChartSectionData(
      color: data[i]['color'],
      value: data[i]['value'].toDouble(),
      title: data[i]['title'],
      radius: radius,
      titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          shadows: shadows
      ),
    );
  });
}
