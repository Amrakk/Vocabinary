import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vocabinary/utils/dimensions.dart';
import 'package:vocabinary/viewmodels/theme_view_model.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Padding(
        padding: EdgeInsets.only(top: Dimensions.height10(context)),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Learn something new",
                  style: GoogleFonts.nanumGothicCoding(
                    fontSize: Dimensions.fontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.height(context, 5)),
            Row(children: [
              Text(
                "Everyday!",
                style: GoogleFonts.anton(
                  fontSize: Dimensions.fontSize(context, 18),
                ),
              ),
            ]),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: Dimensions.width20(context),
            top: Dimensions.height10(context),
          ),
          child: Consumer<ThemeViewModel>(
            builder: (_, themeViewModel, __) => Stack(
              children: [
                Container(
                  height: Dimensions.height(context, 50),
                  width: Dimensions.width(context, 50),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    shape: BoxShape.rectangle,
                    color: themeViewModel.isDarkModeOn
                        ? Colors.black
                        : Colors.white,
                  ),
                  child: Icon(
                    themeViewModel.isDarkModeOn
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: themeViewModel.isDarkModeOn
                        ? Colors.white
                        : Colors.black,
                    size: Dimensions.iconSize30(context),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height(context, 50),
                  width: Dimensions.width(context, 50),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      onTap: () => themeViewModel
                          .updateTheme(!themeViewModel.isDarkModeOn),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
