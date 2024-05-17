import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/api_responses/imgbb_api_res.dart';

class ImageService {
  final pickedFile = null;

  static Future<dynamic> pickImage() async {
    if (getCurrentPlatform() == 'web') {
      XFile? pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        var bytesImage = await pickedFile.readAsBytes();
        return bytesImage;
      } else {
        return null;
      }
    }
    // Android/ Ios
    else {
      XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery);
      if (pickedFile != null) {
        var bytesImage = await pickedFile.readAsBytes();
        return bytesImage;
      }
    }
  }

  static Future<dynamic> uploadImage(Uint8List image) async {
    // Convert to base 64
    String imageBase64 = base64Encode(image);
    String apiKey = dotenv.env['IMAGEBB_API_KEY']!;
    String url = "https://api.imgbb.com/1/upload?key=$apiKey";
    var response = await http.post(Uri.parse(url), body: {
      'image': imageBase64,
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ImgbbResponse imgbb = ImgbbResponse.fromMap(data['data']);
      return imgbb;
    } else {
      return null;
    }
  }
}

  String getCurrentPlatform() {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    return 'android';
  } else if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
    return 'ios';
  } else if (!kIsWeb && defaultTargetPlatform == TargetPlatform.macOS) {
    return 'macos';
  } else if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
    return 'windows';
  } else if (kIsWeb) {
    return 'web';
  } else {
    return 'unknown';
  }
}
