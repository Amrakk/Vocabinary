import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class ItemTopicSelect extends StatefulWidget {
  ItemTopicSelect({required this.name,this.isSelected, required this.onTap, Key? key, required this.id}) : super(key: key);

  final void Function(String id)? onTap;

  final String name;
  final String id;
  final bool? isSelected;

  @override
  State<ItemTopicSelect> createState() => _ItemTopicSelectState();
}

class _ItemTopicSelectState extends State<ItemTopicSelect> {
  bool isSelected = false;
  @override
  void initState() {
    isSelected = widget.isSelected ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onTap!(widget.id);
      },
      borderRadius: BorderRadius.circular(17),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: isSelected ? myColors.blueColor : myColors.containerColor,
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
          child: Center(
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
