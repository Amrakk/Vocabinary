import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vocabinary/viewmodels/community/community_view_model.dart';
import 'package:vocabinary/widgets/community/card_item.dart';
import 'package:vocabinary/widgets/shimmer/topic_loading.dart';

import '../../models/data/topic.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  late CommunityViewModel _topicViewModel;
  bool _isInitiliazed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!_isInitiliazed){
      _topicViewModel = Provider.of<CommunityViewModel>(context, listen: true);
      _topicViewModel.getAllTopicPublic();
      _isInitiliazed = true;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Community",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: _topicViewModel.topicsPublic.isEmpty
                      ? [getLoadingShimmer()]
                      : List.generate(
                      _topicViewModel.topicsPublic.length >= 3
                              ? 3
                              : _topicViewModel.topicsPublic.length, (index) {
                          return Row(
                            children: [
                              CommunityCard(
                                topic: _topicViewModel.topicsPublic[index],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          );
                        })),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Recommend by Vocabinary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _topicViewModel.topicsPublic.isEmpty
                      ? getLoadingShimmer()
                      : const SizedBox(),
                  // CommunityCard(),
                  // SizedBox(width: 20,),
                  // CommunityCard(),
                  // SizedBox(width: 20,),
                  // CommunityCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getLoadingShimmer() {
  return const Row(
    children: [
      ShimmerLoadingTopic(),
      SizedBox(
        width: 20,
      ),
      ShimmerLoadingTopic(),
    ],
  );
}
