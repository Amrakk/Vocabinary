import 'package:flutter/material.dart';
import 'package:vocabinary/widgets/community/card_item.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Community", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CommunityCard(),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            const Text("Recommend by Vocabinary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CommunityCard(),
                  const SizedBox(width: 20,),
                  CommunityCard(),
                  const SizedBox(width: 20,),
                  CommunityCard(),
                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}
