import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/widgets/explore/inside_topic/item_vocab.dart';
import 'package:vocabinary/widgets/global/avatar_mini.dart';
import 'package:vocabinary/widgets/global/button.dart';

class InsideTopicCommunityView extends StatefulWidget {
  const InsideTopicCommunityView({super.key});

  @override
  State<InsideTopicCommunityView> createState() => _InsideTopicCommunityViewState();
}

class _InsideTopicCommunityViewState extends State<InsideTopicCommunityView> {
  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors = Theme.of(context).extension<AppColorsThemeData>()!;
    return   Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: 400,
            width: double.infinity,
            child: Image(
              image: AssetImage('images/nature_background.png'),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black26,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                            color: myColors.containerColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                            color: myColors.containerColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                              child: Icon(
                                Icons.bookmark_add_outlined,
                                size: 30,
                              )
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 35,),
                    const Text("129 Unique Words To Describing Nature", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),maxLines: 2,),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AvatarMini(),
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Center(
                              child: Text("129", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                ),
                child:  Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 410,
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(20, (index) => Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: myColors.containerColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Vocabulary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                ),
                              ),
                              )
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Button(
                          nameButton: "Play!",
                          onPressed: (){},
                          icon: const Icon(Icons.play_circle_outline, size: 30, color: Colors.white,)
                        )
                      ],
                    ),
                  ),
                )
              ),
            ],
          ),
        ],
      )
    );

  }
}
