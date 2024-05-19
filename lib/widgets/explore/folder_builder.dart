
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocabinary/utils/app_colors.dart';
import '../../models/data/folder.dart';

class FolderCard extends StatefulWidget {
   FolderCard({required this.folder  ,super.key});

  FolderModel folder;

  @override
  State<FolderCard> createState() => _FolderCardState();
}

class _FolderCardState extends State<FolderCard> {
  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColor =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return Stack(
         children: [
           const SizedBox(
             width: 160,
             child: Image(
               image: AssetImage('assets/images/folder.png'),
               fit: BoxFit.fitWidth,
             ),
           ),
            Positioned(
             top: 39,
             left: 45,
             child: SizedBox(
               width: 100,
               child: Text(
                 widget.folder.name.toString(),
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
                 style: const TextStyle(fontSize: 15),
               ),
             ),
           ),
           Positioned(
             left: 15,
             top: 75,
             child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   categoryBuilder(
                       title: widget.folder.topicIDs.length.toString(),
                       icon:  Icon(
                         Icons.list,
                         color: myColor.subTextColor,
                         size: 20,
                       )),
                   const SizedBox(width: 10),
                   categoryBuilder(
                       title: widget.folder.createdAtFormatted,
                       icon:  Icon(
                         color: myColor.subTextColor,
                         Icons.calendar_today,
                         size: 15,
                       )),
                 ],
               ),
             ),
           ),
         ],
       );
  }

  Widget categoryBuilder({required String title, required Icon icon}) {
    AppColorsThemeData myColor = Theme.of(context).extension<AppColorsThemeData>()!;
    return Row(
      children: [
        icon,
        const SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(fontSize: 13, color: myColor.subTextColor),
        ),
      ],
    );
  }
}
