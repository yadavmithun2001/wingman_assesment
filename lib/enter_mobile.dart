import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wingman_assesment/api.dart';
import 'package:wingman_assesment/common.dart';
import 'package:wingman_assesment/enter_otp.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0,10),
                  child: Image.asset('assets/logo.png',height: 100,),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text('Get Started',style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.nunito().fontFamily),),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        CountryCodePicker(
                          onChanged: print,
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: 'IN',
                          favorite: ['+91','IN'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: false,
                          // optional. aligns the flag and the Text left

                        ),

                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          child:TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:18
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter Mobile',
                              border: InputBorder.none
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: !_isLoading ? InkWell(
                    onTap: (){
                      if(phoneController.text.isEmpty){
                        showSnackbar(context, 'Please Enter Mobile Number', true);
                      }else if(phoneController.text.length != 10){
                        showSnackbar(context, 'Please Enter Valid Mobile Number', true);
                      }else{
                        setState(() {
                          _isLoading = true;
                        });
                        sendOTP(context,phoneController.text.toString()).then((value){
                          setState(() {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => OTPScreen(number: phoneController.text.toString(),request_id: value,)));
                            _isLoading = false;
                          });
                        });
                      }

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff86106b),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                            child: Text('Continue',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.nunito().fontFamily),),
                          ),
                        ],
                      ),
                    ),
                  ) : Center(
                      child: progreess()
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}

