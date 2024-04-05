import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class searchBar extends StatefulWidget {
  const searchBar({Key? key}) : super(key: key);

  @override
  _searchBarState createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Dimensions.widthSize(context, 70),
        height: 79,
        child: const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: TextField(
              decoration: InputDecoration(
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