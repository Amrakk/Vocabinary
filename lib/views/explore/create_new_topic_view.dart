
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vocabinary/utils/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vocabinary/widgets/explore/create_new_topic/input_description_topic.dart';
import 'package:vocabinary/widgets/global/button.dart';

import '../../widgets/explore/create_new_topic/input_name_topic.dart';

class CreateNewTopic extends StatefulWidget {
  const CreateNewTopic({super.key});

  @override
  State<CreateNewTopic> createState() => _CreateNewTopicState();
}

class _CreateNewTopicState extends State<CreateNewTopic> {
  bool isPublic = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled){
          return [
             SliverAppBar(
               expandedHeight: Dimensions.heightRatio(context, 35),
              floating: true,
              snap: true,
              flexibleSpace: PreferredSize(
                  preferredSize: Size.fromHeight(Dimensions.heightRatio(context, 35)),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration:  const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF003566),
                              Color(0xFF006FD6),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: AppBar(
                          title: const Text('Create New Topic', style: TextStyle(fontWeight: FontWeight.w500),),
                          centerTitle: true,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Positioned(
                        bottom: Dimensions.heightRatio(context, -5),
                        left: MediaQuery.of(context).size.width / 2 - Dimensions.widthRatio(context, 30),
                        child: const InputTopicName(),
                      )
                    ],
                  )
              ),
            ),
          ];
        },
        body:  Padding(
          padding: EdgeInsets.all(Dimensions.padding30(context)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.heightRatio(context,6 )),
                Text('Add to description', style: TextStyle(fontSize: Dimensions.fontSize(context, 22), fontWeight: FontWeight.normal),),
                SizedBox(height: Dimensions.heightRatio(context, 2)),
                const InputDescriptionTopic(),
                SizedBox(height: Dimensions.heightRatio(context, 3)),
                Text('Upload cover photo', style: TextStyle(fontSize: Dimensions.fontSize(context, 22), fontWeight: FontWeight.normal),),
                Center(
                  child: SizedBox(
                    height: Dimensions.heightRatio(context, 22),
                    child: GestureDetector(
                      onTap: (){
                        // Todo: Add image picker
                      },
                      child: SvgPicture.asset('assets/images/upload.svg',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.heightRatio(context, 3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Public Topic', style: TextStyle(fontSize: Dimensions.fontSize(context, 22), fontWeight: FontWeight.normal),),
                    CupertinoSwitch(value: isPublic, onChanged: (value) {
                      setState(() {
                        isPublic = value;
                      });
                    })
                  ],
                ),
                SizedBox(height: Dimensions.heightRatio(context, 4)),
                Button(nameButton: 'Apply'),
              ],
            ),
          ),
        )
      ),
    );
  }
}

