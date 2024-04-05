import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/home/drop_down_button.dart';
import 'package:vocabinary/widgets/home/pie_chart.dart';
import 'package:vocabinary/widgets/my_animated_container.dart';

import '../../widgets/home/line_chart_titles.dart';
import '../../widgets/home/line_chart.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
      padding: const EdgeInsets.only(top: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAnimatedContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Vocabulary',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MyDropDownButton()
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: Dimensions.heightSize(context, 30),
                      child: const MyLineChart(),
                    )
                  ]
                ),
              ),
              const SizedBox(height: 20,),
              MyAnimatedContainer(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Word Level',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: Dimensions.heightSize(context, 30),
                        child: const MyPieChart(),
                      ),
                      const SizedBox(height: 20,)
                    ]
                ),
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
