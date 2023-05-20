import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wingman_assesment/common.dart';

String baseUrl = "https://test-otp-api.7474224.xyz";
Uri getUri({required String endPoint}){
  print("${baseUrl}/${endPoint}");
  return Uri.parse("${baseUrl}/${endPoint}");
}

Future <String> sendOTP(BuildContext context,String phone) async {
  var body = jsonEncode({ 'mobile': phone });
  var response = await http.post(
      getUri(endPoint: 'sendotp.php'),
    body: body
  );
  String result = 'false';
  print("response came here " + response.body);
  if(response.statusCode == 200){
    result = json.decode(response.body)["request_id"];
    showSnackbar(context, json.decode(response.body)["response"], false);
  }
  return result;
}

String jwt = "";
Future <String> Verifyotp(BuildContext context,String request_id,String otp) async {
  var body = jsonEncode({
    "request_id" : request_id,
    "code" : otp
  });
  var response = await http.post(
      getUri(endPoint: 'verifyotp.php'),
    body: body
  );
  String result="";
  print("response came here " + response.body);
  if(response.statusCode == 200){
    result = response.body.toString();
    if(json.decode(response.body)['status'].toString() == 'true'){
      jwt = json.decode(response.body)['jwt'];
    }else{
      showSnackbar(context, json.decode(response.body)['response'].toString(), true);
    }
  }
  return result;
}

Future <bool> submitprofile(BuildContext context,String jwtoken,String name,String email) async {
  var body = jsonEncode({
    "name" : name,
    "email" : email
  });
  var response = await http.post(
      getUri(endPoint: 'profilesubmit.php'),
      body: body,
    headers: {
        "Token":jwtoken
    }
  );
  bool result = false;
  print("response came here " + response.body);
  if(response.statusCode == 200){
    if(json.decode(response.body)['status'].toString() == 'true'){
      result = true;
      showSnackbar(context, json.decode(response.body)['response'].toString(), false);
    }else{
      result = false;

    }
  }
  return result;
}