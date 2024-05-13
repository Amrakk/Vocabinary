import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthenticateViewModel extends ChangeNotifier {
  final String _secretKey = "JZUW42BAIRXW4ZY=";

  String generateOtp() {
    return OTP.generateTOTPCodeString(
      _secretKey,
      DateTime.now().millisecondsSinceEpoch,
      interval: 180,
      length: 6,
    );
  }

  bool verifyOtp(String otp) {
    return OTP.constantTimeVerification(
        OTP.generateTOTPCodeString(
          _secretKey,
          DateTime.now().millisecondsSinceEpoch,
          interval: 180,
          length: 6,
        ),
        otp);
  }

  Future<bool> sendEmail(String toEmail) async {
    final url = Uri.parse('https://api.mailersend.com/v1/email');
    final templateHtml =  ''' <div style="font-family: Helvetica,Arial,sans-serif;min-width:1000px;overflow:auto;line-height:2">
  <div style="margin:50px auto;width:70%;padding:20px 0">
    <div style="border-bottom:1px solid #eee">
      <a href="" style="font-size:1.4em;color: #00466a;text-decoration:none;font-weight:600">Vocabinary</a>
    </div>
    <p style="font-size:1.1em">Hi,</p>
    <p>Use the following OTP to complete your Sign Up procedures. OTP is valid for 3 minutes</p>
    <h2 style="background: #00466a;margin: 0 auto;width: max-content;padding: 0 10px;color: #fff;border-radius: 4px;">${generateOtp()}</h2>
    <p style="font-size:0.9em;">Regards,<br />Vocabinary</p>
    <hr style="border:none;border-top:1px solid #eee" />
    <div style="float:right;padding:8px 0;color:#aaa;font-size:0.8em;line-height:1;font-weight:300">
      <p>Vocabinary</p>
    </div>
  </div>
</div>  ''';

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization' : 'Bearer ${dotenv.env['EMAIL_API_KEY']}',
      },
      body: json.encode({
        "from": {
          "email": "MS_7U4Ztf@ninhdong.free.nf",
          "name": "Vocabinary"
        },
        "to": [
          {
            "email": toEmail,
          }
        ],
        "subject": "Vocabinary - OTP for Sign Up",
        "html": templateHtml
      }),
    );
    if (response.statusCode == 202 || response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

}
