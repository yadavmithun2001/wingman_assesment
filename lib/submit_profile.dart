import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wingman_assesment/api.dart';
import 'package:wingman_assesment/common.dart';
import 'package:wingman_assesment/enter_otp.dart';
import 'package:wingman_assesment/home.dart';
class SubmitProfile extends StatefulWidget {
  final String mobile;
  final String JwtKey;
  const SubmitProfile({super.key, required this.JwtKey, required this.mobile});

  @override
  State<SubmitProfile> createState() => _SubmitProfileState();
}

class _SubmitProfileState extends State<SubmitProfile> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    print('jwt ' + widget.JwtKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text('Welcome',style: TextStyle(color: Color(0xff86106b),fontSize:18,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.nunito().fontFamily),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 10),
                child: Text('Looks Like you are new here. Tell us a bit more about yourself.',style: TextStyle(fontSize:15,fontFamily: GoogleFonts.nunito().fontFamily,color: Colors.grey.shade700),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text('Name',style: TextStyle(color:  Color(0xff86106b),fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child : Container(
                        child:Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                                fontSize:16
                            ),
                            decoration: InputDecoration(
                                hintText: 'Enter Name',
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      )

                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text('Email',style: TextStyle(color:  Color(0xff86106b),fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child : Container(
                      child:Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize:16
                          ),
                          decoration: InputDecoration(
                              hintText: 'Enter Email',
                              border: InputBorder.none
                          ),
                        ),
                      ),
                    )

                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: !_isLoading ? InkWell(
                  onTap: (){
                    if(phoneController.text.isEmpty){
                      showSnackbar(context, 'Please Enter Name', true);
                    }else if(emailController.text.isEmpty){
                      showSnackbar(context, 'Please Enter Email address', true);
                    }else{
                      setState(() {
                        _isLoading = true;
                      });
                      submitprofile(context,widget.JwtKey,phoneController.text.toString(),emailController.text.toString()).then((value){
                        setState(() {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => HomePage(MobileNumber: widget.mobile, jwtKey: widget.JwtKey)));
                          _isLoading = false;
                        });
                      });
                    }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color:  Color(0xff86106b),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                          child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.nunito().fontFamily),),
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

