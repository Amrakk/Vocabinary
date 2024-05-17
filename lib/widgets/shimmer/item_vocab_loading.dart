import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';


class ItemVocabLoading extends StatelessWidget {
  const ItemVocabLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: Dimensions.heightRatio(context, 10),
        width: double.infinity,
        decoration:   BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Colors.grey[800]
        ),
        child:  Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Dimensions.heightRatio(context, 1),
                    width: Dimensions.widthRatio(context, 25),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Container(
                    height: Dimensions.heightRatio(context, 1),
                    width: Dimensions.widthRatio(context, 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )

                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Dimensions.heightRatio(context, 1),
                    width: Dimensions.widthRatio(context, 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(15),

                    ),
                  ),
                  Container(
                    height: Dimensions.heightRatio(context, 1),
                    width: Dimensions.widthRatio(context, 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )

                ],
              ),

            ],
          ),
        ),
      );
  }
}
