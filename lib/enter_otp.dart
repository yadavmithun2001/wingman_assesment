import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:wingman_assesment/api.dart';
import 'package:wingman_assesment/home.dart';
import 'package:wingman_assesment/submit_profile.dart';

class OTPScreen extends StatefulWidget {
  final String number;
  final String request_id;
  const OTPScreen({Key? key, required this.number, required this.request_id}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool otpnmatched = false;
  bool _isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    print('request id ' + widget.request_id);
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor =  Color(0xff86106b);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Colors.amber;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Image.asset('assets/logo.png',height: 100,),
            SizedBox(height: 0),
            Center(child: Text('Verification',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 22,fontFamily: GoogleFonts.poppins().fontFamily ),)),
            Text('Enter the One Time Password (OTP) sent to',),
            SizedBox(height: 5,),
            Text('+91 ' + widget.number,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:  Color(0xff86106b)),),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Directionality(
                      // Specify direction if desired
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: pinController,
                        focusNode: focusNode,
                        length: 6,
                        androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        // validator: (value) {
                        //   return otpnmatched == true ? null : 'OTP is not valid! ';
                        // },
                        // onClipboardFound: (value) {
                        //   debugPrint('onClipboardFound: $value');
                        //   pinController.setText(value);
                        // },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          setState(() {
                            _isloading = true;
                          });
                          Verifyotp(context, widget.request_id, pin).then((value) {
                              setState(() {
                                if(json.decode(value)['status'].toString() == 'true'){
                                  if(json.decode(value)['profile_exists'].toString() == 'true'){
                                    _isloading = false;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(MobileNumber:widget.number,jwtKey: jwt,)));
                                  }else{
                                    _isloading = false;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitProfile(JwtKey: jwt,mobile: widget.number,)));
                                  }
                                }else{
                                   _isloading = false;
                                }
                              });
                            });

                          // if(pin=='123456'){
                          //   showSnackbar(context, 'OTP Verified Successfully', false);
                          //   setState(() {
                          //     isOTPVerified = true;
                          //   });
                          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                          //       Register()
                          //   ));
                          // }else{
                          //   showSnackbar(context, 'OTP is invalid! ', true);
                          // }

                        },
                        onChanged: (value) {
                          print('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            _isloading ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.black,
                  size: 30,
                  secondRingColor: Colors.amber,
                  thirdRingColor: Colors.amber),
            ) : Container(),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Wrong Number? '),
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text('Retry',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),))
                    ],
                  ),
                  Row(
                    children: [
                      Text('Didn\'t receive code '),
                      InkWell(
                          onTap: (){
                            sendOTP(context, widget.number).then((value) {
                            });
                          },
                          child: Text('Resend',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,),))
                    ],
                  ),

                ],
              ),
            ),

            Expanded(child: SizedBox()),
          ],
        ),
      ),

    );
  }
}