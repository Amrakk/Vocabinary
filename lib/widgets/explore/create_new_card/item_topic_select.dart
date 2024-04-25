import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class ItemTopicSelect extends StatefulWidget {
  const ItemTopicSelect({super.key});

  @override
  State<ItemTopicSelect> createState() => _ItemTopicSelectState();
}

class _ItemTopicSelectState extends State<ItemTopicSelect> {
  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors = Theme.of(context).extension<AppColorsThemeData>()!;
    return InkWell(
      onTap: (){},
      borderRadius: BorderRadius.circular(17),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: myColors.containerColor,
        ),
        child: Container(
          height: 42,
          width: 90,
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
          child: const Center(
            child: Text(
              'Nature',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
