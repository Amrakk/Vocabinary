import 'package:flutter/material.dart';
import 'package:vocabinary/utils/app_colors.dart';

class Category extends StatefulWidget {
   Category({ this.date, bool? isBorder  ,String? level, int? size, int? amountSaved, bool? isDate ,bool? isLevel, bool? isSize, bool? isAmountSaved ,super.key}):
         isLevel = isLevel ?? false,
         isSize = isSize ?? false,
         isAmountSaved = isAmountSaved ?? false,
         level = level ?? "Easy",
         size = size ?? 0,
         amountSaved = amountSaved ?? 0,
         isDate = isDate ?? false,
         isBorder = isBorder ?? true;

  bool isLevel;
  bool isSize;
  bool isAmountSaved;
  bool isDate;
  bool isBorder;

  String level = "Easy";
  int size;
  int amountSaved;
  DateTime? date;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    AppColorsThemeData _appColorsThemeData = Theme.of(context).extension<AppColorsThemeData>()!;
    return   Container(
        decoration: BoxDecoration(
          color: widget.isBorder ? const Color(0x73757575) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.isLevel ? const Icon(Icons.leaderboard, size: 14,) : const SizedBox(),
              widget.isSize ? const Icon(Icons.list, size: 20,) : const SizedBox(),
              widget.isAmountSaved ? const Icon(Icons.bookmark_sharp, size: 14,) : const SizedBox(),
              widget.isDate ? const Icon(Icons.calendar_today, size: 14,) : const SizedBox(),
              const SizedBox(width: 5,),
              widget.isLevel ? Text(widget.level, style: const TextStyle(fontSize: 12),) : const SizedBox(),
              widget.isSize ? Text(widget.size.toString(), style: const TextStyle( fontSize: 12),) : const SizedBox(),
              widget.isAmountSaved ? Text(widget.amountSaved.toString(), style: const TextStyle(fontSize: 12),) : const SizedBox(),
              widget.isDate ? Text(widget.date.toString(), style: const TextStyle(fontSize: 12),) : const SizedBox(),
            ],
          ),
        )
    );
  }
}
