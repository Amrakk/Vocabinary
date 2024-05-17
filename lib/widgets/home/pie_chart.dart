import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:vocabinary/models/data/word.dart';
import 'package:vocabinary/utils/colors.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/home/indicator.dart';

int touchedIndex = -1;

class MyPieChart extends StatefulWidget {
  final words;

  const MyPieChart({super.key, this.words});

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  @override
  void initState() {
    calculateDataPercentage(widget.words);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: Dimensions.widthRatio(context, 50),
          child: PieChart(
            PieChartData(
              centerSpaceRadius: Dimensions.width(context, 55),
              sectionsSpace: Dimensions.width10(context),
              pieTouchData: PieTouchData(
                touchCallback: (event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              sections: showingSections(),
            ),
          ),
        ),
        SizedBox(width: Dimensions.widthRatio(context, 5)),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Indicator(
              color: AppColors.pieChartIndicator['Easy']!,
              text: 'Easy',
              isSquare: true,
            ),
            SizedBox(height: Dimensions.height(context, 4)),
            Indicator(
              color: AppColors.pieChartIndicator['Normal']!,
              text: 'Normal',
              isSquare: true,
            ),
            SizedBox(height: Dimensions.height(context, 4)),
            Indicator(
              color: AppColors.pieChartIndicator['Hard']!,
              text: 'Hard',
              isSquare: true,
            ),
            SizedBox(height: Dimensions.height(context, 4)),
          ],
        ),
      ],
    );
  }
}

void calculateDataPercentage(List<WordModel> words) {
  //iterating over the words and calculating the percentage of each level
  var easy = 0;
  var normal = 0;
  var hard = 0;
  for (var word in words) {
    if (word.level == 1) {
      easy++;
    } else if (word.level == 2) {
      normal++;
    } else if (word.level == 3) {
      hard++;
    }
  }
  data = [
    {
      'color': AppColors.pieChartIndicator['Easy']!,
      'value': easy,
      'title': '${(easy / words.length * 100).toStringAsFixed(0)}%',
    },
    {
      'color': AppColors.pieChartIndicator['Normal']!,
      'value': normal,
      'title': '${(normal / words.length * 100).toStringAsFixed(0)}%',
    },
    {
      'color': AppColors.pieChartIndicator['Hard']!,
      'value': hard,
      'title': '${(hard / words.length * 100).toStringAsFixed(0)}%',
    },
  ];
}

List<Map<String, dynamic>> data = [];

List<PieChartSectionData> showingSections() {
  return List.generate(3, (i) {
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
        shadows: shadows,
      ),
    );
  });
}
