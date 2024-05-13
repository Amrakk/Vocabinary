import 'package:flutter/material.dart';
import 'package:vocabinary/utils/app_colors.dart';
import 'package:vocabinary/widgets/global/category.dart';
import 'package:vocabinary/widgets/global/avatar_mini.dart';

class CommunityCard extends StatefulWidget {
   CommunityCard({super.key});

  String nameTopic = "Snacks and desserts in Britain";
  int level = 2;
  int size = 100;
  int amountSaved = 100;

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors = Theme.of(context).extension<AppColorsThemeData>()!;
    return Container(
      width: 200,
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
      child:   Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Image(
                image: AssetImage('images/food.png'),
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
           Padding(
             padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
               children: [
                   const Text("Snacks and desserts in Britain", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold), maxLines: 2,),
                  const SizedBox(height: 15,),
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Row(
                     children: [
                       widget.level == 1 ? Category(isLevel: true, level: "Easy") : widget.level == 2 ? Category(isLevel: true, level: "Medium") : Category(isLevel: true, level: "Hard"),
                       const SizedBox(width: 10,),
                        Category(isSize: true, size: widget.size),
                        const SizedBox(width: 10,),
                        Category(isAmountSaved: true, amountSaved: widget.amountSaved),
                     ],
                   ),
                 ),
                  const SizedBox(height: 15,),
                  AvatarMini(),
               ],
             ),
           )
          ],
        ),
      ),
    );
  }
}
