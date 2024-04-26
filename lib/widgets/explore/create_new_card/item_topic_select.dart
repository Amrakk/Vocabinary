import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class ItemTopicSelect extends StatefulWidget {
   ItemTopicSelect({ required this.name ,void Function()? onTap ,super.key}) : onTap = onTap ?? ((){});

  void Function()? onTap ;
  String name;

  @override
  State<ItemTopicSelect> createState() => _ItemTopicSelectState();
}

class _ItemTopicSelectState extends State<ItemTopicSelect> {
  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors = Theme.of(context).extension<AppColorsThemeData>()!;
    return InkWell(
      onTap: (){
        widget.onTap!();
      },
      borderRadius: BorderRadius.circular(17),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: myColors.containerColor,
        ),
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 3,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child:  Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
