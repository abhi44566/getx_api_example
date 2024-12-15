import 'dart:convert';

import 'package:get/get.dart';
import 'package:getxproject/otp.dart';
import 'package:getxproject/utils/my_session.dart';
import 'package:http/http.dart' as http;


class LoginController extends GetxController{
  var isLoading = false;
  
  Future<void> fetchLogin(String mobile) async {
    try{
      isLoading = true;
      update();
      final api = await http.post(Uri.parse("https://saudashi.com/daily_dite/daily_dite_server/daily_dite_app/API/api/dd_cust_login"),body: {
        'mobile_number': mobile,
        'device_token':''
      });

      if(api.statusCode == 200){
        if(jsonDecode(api.body)['response']['status'] == true){
          isLoading = false;

          MySession.setUserId(jsonDecode(api.body)['response']['user_id']);
          Get.to(()=> OtpScreen(otp: jsonDecode(api.body)['response']['otp_code'],));
          update();
          Get.snackbar("otp", jsonDecode(api.body)['response']['otp_code']);
        }else{
          print(jsonDecode(api.body)['response']['msg'] );
        }
      }
    }catch(e){
      print(e);
    }
    finally{
      isLoading = false;
      update();
    }
  }
}