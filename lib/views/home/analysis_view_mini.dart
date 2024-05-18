import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/widgets/home/pie_chart.dart';
import 'package:vocabinary/widgets/my_animated_container.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/viewmodels/home_view_model.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({super.key});

  @override
  State<AnalysisView> createState() {
    return _AnalysisViewState();
  }
}

class _AnalysisViewState extends State<AnalysisView> {
  late Future<void> _loadVocabularyFuture;
  late HomePageViewModel _homePageViewModel;

  @override
  void initState() {
    AuthenticationService _authenticationService =
        AuthenticationService.instance;
    String uid = _authenticationService.currentUser?.uid ?? '';
    _homePageViewModel = HomePageViewModel(uid);
    _loadVocabularyFuture = _homePageViewModel.getWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.height20(context)),
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // MyAnimatedContainer(
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'Total Vocabulary',
              //             style: TextStyle(
              //               fontSize: Dimensions.fontSize(context, 19),
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           const MyDropDownButton()
              //         ],
              //       ),
              //       SizedBox(height: Dimensions.height30(context)),
              //       SizedBox(
              //         height: Dimensions.heightRatio(context, 30),
              //         child: const MyLineChart(),
              //       )
              //     ],
              //   ),
              // ),
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
                      child: FutureBuilder(
                          future: _loadVocabularyFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('Loading...',
                                  style: TextStyle(fontWeight: FontWeight.bold));
                            } else if (snapshot.hasError) {
                              return const Text('Error');
                            } else {
                              if(_homePageViewModel.words.isEmpty){
                                return const Text('No word added yet.');
                              }else{
                                return MyPieChart(
                                    words: _homePageViewModel.words);
                              }
                            }
                          }),
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
