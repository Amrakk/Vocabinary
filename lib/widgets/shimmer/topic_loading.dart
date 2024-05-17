import 'package:flutter/material.dart';

class ShimmerLoadingTopic extends StatelessWidget {
  const ShimmerLoadingTopic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(height: 12,),
                Container(
                  width: 150,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(height: 12,),
                Container(
                  width: 100,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            )
          )
        ],
      )
    );
  }
}
