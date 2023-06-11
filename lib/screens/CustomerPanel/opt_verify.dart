import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import '../../provider/user_id_class.dart';
import '../../routes/routes.dart';
import '../login_registration/input_field.dart';
import '../login_registration/theme.dart';
import '../login_registration/custom_primary_button.dart';
import 'dart:math';


class SendOTP extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SendOTP> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController otpController =
  TextEditingController(text: '');

  bool passwordVisible = false;
  var intValue;
  void sendotp() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Your OTP is sent",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    intValue = Random().nextInt(1000000);
    UserID().sendmail("mustafa", "jovin32735@onlcool.com", "OTP", "message:your OTP is \n ${intValue}",emailController.text);
  }
  void verifyotp(){
     if(intValue.toString()==otpController.text.toString()){
     Navigator.pushNamed(context, Routes.forgetpasswordScreenCustomer,
         arguments: emailController.text.toString());
   }
   else{
    _showDialog(context);
   }
  }

  bool islogin = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verify OTP',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 200,
                      child: Image.asset(
                        'assets/images/accent.png',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Form(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 32,
                      ),
                      InputField(
                        hintText: 'Email',
                        controller: emailController,
                        suffixIcon: IconButton(
                          color: textBlack,
                          splashRadius: 1,
                          icon: Icon(Icons.send),
                          onPressed: sendotp,
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      InputField(
                        hintText: 'OTP',
                        suffixIcon:SizedBox(),
                        controller: otpController,
                        obscureText: !passwordVisible,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 32,
                ),
                CustomPrimaryButton(
                    buttonColor: Color(0xfffbfbfb),
                    textValue: 'Verify',
                    textColor: textBlack,
                    onPressed: () {
                         verifyotp();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  //Navigator.of(context).pop();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Invalid OTP"),
        content: Text("Enter Correct OTP Thank You!"),
        actions: <Widget>[
          ElevatedButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



