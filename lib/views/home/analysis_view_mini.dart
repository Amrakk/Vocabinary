import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/home/pie_chart.dart';
import 'package:vocabinary/widgets/home/line_chart.dart';
import 'package:vocabinary/widgets/my_animated_container.dart';
import 'package:vocabinary/widgets/home/drop_down_button.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({super.key});

  @override
  State<AnalysisView> createState() {
    return _AnalysisViewState();
  }
}

class _AnalysisViewState extends State<AnalysisView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.height20(context)),
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAnimatedContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Vocabulary',
                          style: TextStyle(
                            fontSize: Dimensions.fontSize(context, 19),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const MyDropDownButton()
                      ],
                    ),
                    SizedBox(height: Dimensions.height30(context)),
                    SizedBox(
                      height: Dimensions.heightRatio(context, 30),
                      child: const MyLineChart(),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20(context)),
              MyAnimatedContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Word Level',
                          style: TextStyle(
                            fontSize: Dimensions.fontSize20(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height30(context)),
                    SizedBox(
                      height: Dimensions.heightRatio(context, 30),
                      child: const MyPieChart(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height(context, 40)),
            ],
          ),
        ),
      ),
    );
  }
}
