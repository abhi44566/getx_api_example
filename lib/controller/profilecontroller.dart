import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getxproject/otp.dart';
import 'package:getxproject/response/profile_response.dart';
import 'package:getxproject/utils/my_session.dart';
import 'package:http/http.dart' as http;

import '../profile.dart';

class Profilecontroller extends GetxController{
var isLoading=false;
  final profile = ProfileResponse().obs;
  
  Future<void> fetchProfile() async {
    final userId= await MySession.getUserId();
    try{
      update();
      final api = await http.post(Uri.parse("https://saudashi.com/daily_dite/daily_dite_server/daily_dite_app/API/api/dd_cust_get_profile"),body: {
        'user_id': userId
      });

      if(api.statusCode == 200){
        if(jsonDecode(api.body)['response']['status'] == true){
          profile.value = ProfileResponse.fromJson(jsonDecode(api.body));
        }else{
          print(jsonDecode(api.body)['response']['msg'] );
        }
        update();
      }
    }catch(e){
      print(e);
    }

  }

  Future<void> updateProfile(String fullName, mobileNumber, emailId, gender,
      File? selectedImage) async {
    try {
      isLoading = true;
      update();
      final userId = await MySession.getUserId();
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "https://saudashi.com/daily_dite/daily_dite_server/daily_dite_app/API/api/dd_update_profile"));
      request.fields['user_id'] = userId;
      request.fields['full_name'] = fullName;
      request.fields['mobile_number'] = mobileNumber;
      request.fields['email_id'] = emailId;
      request.fields['gender'] = gender;

      if (selectedImage != null) {
        var image = await http.MultipartFile.fromPath(
            'attachment_tag', selectedImage.path);
        request.files.add(image);
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(await response.stream.bytesToString());

        if (responseData['response']['status'] == true) {
          fetchProfile();
          Get.snackbar("Success", responseData['response']['msg']);
        } else {
    Get.snackbar("Success", responseData['response']['msg']);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    } finally {
      isLoading = false;
      update();
    }
  }
}