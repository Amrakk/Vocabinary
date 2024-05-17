import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/viewmodels/community/community_view_model.dart';
import 'package:vocabinary/widgets/community/item_community_card.dart';
import 'package:vocabinary/widgets/shimmer/topic_loading.dart';

import '../../models/arguments/explore/topic_args.dart';
import '../../routes/routes.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  late CommunityViewModel _topicViewModel;
  bool _isInitiliazed = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_isInitiliazed) {
      _topicViewModel = Provider.of<CommunityViewModel>(context, listen: true);
      await _topicViewModel.getAllTopicPublic();
      await _topicViewModel.getAllTopicFollowing();
      _isInitiliazed = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Community",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(AppRoutes.exploreRoutes[0],
                            arguments: TopicArguments(
                              topics: _topicViewModel.topicsPublic,
                              userID: "",
                            ));
                  },
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
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
            Row(
              children: [
                const Text(
                  "Topic followed by You",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(AppRoutes.exploreRoutes[0],
                            arguments: TopicArguments(
                              topics: _topicViewModel.topicsFollowing,
                              userID: "",
                            ));
                  },
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: !_isInitiliazed
                    ? [getLoadingShimmer()]
                    : _topicViewModel.topicsFollowing.isEmpty
                        ? [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "You are not following any topic",
                              style: TextStyle(fontSize: 15),
                            )
                          ]
                        : List.generate(
                            _topicViewModel.topicsFollowing.length >= 3
                                ? 3
                                : _topicViewModel.topicsFollowing.length,
                            (index) {
                            return Row(
                              children: [
                                CommunityCard(
                                  topic: _topicViewModel.topicsFollowing[index],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            );
                          }),
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
