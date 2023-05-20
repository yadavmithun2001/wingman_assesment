import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  final String MobileNumber;
  final String jwtKey;
  const HomePage({Key? key, required this.MobileNumber, required this.jwtKey}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xff86106b),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Center(child: Text('Welcome ' + widget.MobileNumber,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                Center(child: Text('JWT Token: ' + widget.jwtKey,style: TextStyle(color: Colors.white,fontSize: 16))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                          child: Column(
                            children: [
                              Icon(Icons.account_circle,size: 50,color: Color(0xff86106b),),
                              Text(
                                '    Profile    ',
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Color(0xff86106b)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                          child: Column(
                            children: [
                              Icon(Icons.notification_add,size: 50,color: Color(0xff86106b),),
                              Text(
                                  'Notification',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Color(0xff86106b)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


              ]
            ),
          ],
        ),
      ),
    );
  }
}
