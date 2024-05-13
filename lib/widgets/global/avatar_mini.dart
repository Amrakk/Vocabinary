import 'package:flutter/material.dart';

class AvatarMini extends StatefulWidget {
   AvatarMini({super.key});

  String name = "Ninh Dong";
  String avatar = "images/avatar.jpg";

  @override
  State<AvatarMini> createState() => _AvatarMiniState();
}

class _AvatarMiniState extends State<AvatarMini> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        CircleAvatar(
          radius: 17,
          backgroundImage: AssetImage(widget.avatar),
        ),
        const SizedBox(width: 10),
         Text(
          widget.name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
