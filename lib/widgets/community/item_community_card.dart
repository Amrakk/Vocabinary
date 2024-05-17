import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/models/arguments/explore/inside_topic_args.dart';
import 'package:vocabinary/models/data/topic.dart';
import 'package:vocabinary/models/data/user.dart';
import 'package:vocabinary/routes/routes.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/viewmodels/community/community_view_model.dart';
import 'package:vocabinary/widgets/global/category.dart';
import 'package:vocabinary/widgets/global/avatar_mini.dart';

class CommunityCard extends StatefulWidget {
  CommunityCard({required this.topic, super.key});

  TopicModel topic;

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  late UserModel ownerCard = UserModel(
    name: "Unknown",
    email: "Unknown",
    avatar: "",
  );
  late CommunityViewModel _communityViewModel;

 void init() async {
   _communityViewModel = Provider.of<CommunityViewModel>(context, listen: false);
      ownerCard = await _communityViewModel.getOwner(widget.topic.ownerID!) ?? UserModel(
          name: "Unknown",
          email: "Unknown",
          avatar: "",
      );
      setState(() {
      });
 }

 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }


  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return GestureDetector(
      onTap: () async {
        Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.communityRoutes[0],
            arguments: InsideTopicArgs(
                topicId: widget.topic.id!,
                topicName: widget.topic.name!,
                wordCount: widget.topic.wordCount,
                topicModel: widget.topic
            ));
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: myColors.containerColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                height: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    widget.topic.imageTopic!,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: LoadingIndicator(
                            indicatorType: Indicator.squareSpin,
                            colors: [Colors.blue],
                          ),
                        ),
                      );
                    },
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.topic.name!,
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          widget.topic.level == 1
                              ? Category(isLevel: true, level: "Easy")
                              : widget.topic.level == 2
                                  ? Category(isLevel: true, level: "Medium")
                                  : Category(isLevel: true, level: "Hard"),
                          const SizedBox(
                            width: 10,
                          ),
                          Category(isSize: true, size: widget.topic.wordCount),
                          const SizedBox(
                            width: 10,
                          ),
                          Category(
                              isAmountSaved: true,
                              amountSaved: widget.topic.followers.length),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AvatarMini(user: ownerCard),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
