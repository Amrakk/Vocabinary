import 'package:flutter/material.dart';
import 'package:vocabinary/views/home/today_word_view_mini.dart';

import '../../utils/dimensions.dart';
import '../../widgets/home/search_bar.dart';
import 'analysis_view_mini.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _selectedIndexTabbBar = 1;

   List<Widget> listTab = [
     const TodayWorldView(),
     const AnalysisView(),
  ];

  @override
  Widget build(BuildContext context) {
    return  NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          const SliverToBoxAdapter(
            child: searchBar(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 15),
          ),
          SliverToBoxAdapter(
              child: Stack(
                children: [
                  Align(
                    child: Container(
                        width: Dimensions.widthSize(context, 60),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedIndexTabbBar = 0;
                                });
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: AnimatedContainer(
                                curve: Curves.easeInOut,
                                width: Dimensions.widthSize(context, 30),
                                decoration: BoxDecoration(
                                  color: _selectedIndexTabbBar == 0
                                      ? Colors.red
                                      : Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                duration: const Duration(milliseconds: 300),
                                child: const Center(
                                  child: Text(
                                      textAlign: TextAlign.center,
                                      'TODAY\'S WORD',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedIndexTabbBar = 1;
                                });
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: AnimatedContainer(
                                curve: Curves.easeInOut,
                                width: Dimensions.widthSize(context, 30),
                                decoration: BoxDecoration(
                                  color: _selectedIndexTabbBar == 1
                                      ? Colors.red
                                      : Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                duration: const Duration(milliseconds: 300),
                                child: const Center(
                                  child: Text('ANALYZE',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              )),
        ];
      },
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: listTab[_selectedIndexTabbBar],
      ),
    );
  }
}
