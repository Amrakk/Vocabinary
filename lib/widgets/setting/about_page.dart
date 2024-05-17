import 'package:flutter/material.dart';
import 'package:vocabinary/utils/app_colors.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: myColors.containerColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vocabinary', style: TextStyle(fontSize: 30,color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                Text('Version: 1.0.0', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Divider(
                  color: Colors.white24,
                  endIndent: 30,
                  thickness: 1,
                ),
                SizedBox(height: 5),

                Text('Developed by Nguyễn Hoàng Duy'),
                Row(
                  children: [
                    SizedBox(width: 90),
                    Text("Nguyễn Hồ Nhật Nam"),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 90),
                    Text("Nguyễn Thiện Ninh Đồng"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
