import 'package:flutter/material.dart';
import 'package:vocabinary/models/data/user.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';

class AvatarMini extends StatefulWidget {
   AvatarMini({required this.user, super.key});

   UserModel user;

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
          backgroundImage: widget.user.avatar!.isNotEmpty
              ? NetworkImage(widget.user.avatar!)
              : Image.asset('assets/images/avatar.jpg').image,
        ),
        const SizedBox(width: 10),
         Text(
          widget.user.name.toString(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
