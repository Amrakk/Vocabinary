import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBarApp(BuildContext context) {
  return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Learn something new",
                  style: GoogleFonts.nanumGothicCoding(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(children: [
              Text(
                "Everyday!",
                style: GoogleFonts.anton(fontSize: 18),
              ),
            ]),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 10.0),
          child: Stack(children: [
            Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  shape: BoxShape.rectangle,
                  color: Color(0xFF000000),
                ),
                child: const Icon(
                  Icons.dark_mode,
                  color: Colors.white,
                  size: 30,
                )),
            SizedBox(
              height: 50,
              width: 50,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(10)),
                  onTap: () {
                    // TODO: Implement dark mode
                  },
                ),
              ),
            ),
          ]),
        ),
      ]
  );
}