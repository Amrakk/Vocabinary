import '../../utils/dimensions.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const HomeSearchBar({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Dimensions.widthRatio(context, 70),
        height: 79,
        child: Padding(
          padding: EdgeInsets.only(top: Dimensions.height20(context)),
          child: Material(
            elevation: 4,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter a search term',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
