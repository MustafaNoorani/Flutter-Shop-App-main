import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/WholesalerProfile.dart';
import 'package:shop_app/screens/login_registration/wholesaler_registration.dart';
import 'package:shop_app/screens/profile.dart';
import '../../provider/user_id_class.dart';
import '../../provider/user_provider.dart';
import '../CustomerPanel/opt_verify.dart';
import './input_field.dart';
import './theme.dart';
import './custom_primary_button.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(text:'');

  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }
  bool islogin = false;
  void showDialoge(BuildContext context)
  {
    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          print(islogin);
          if(islogin==true){
            Navigator.of(context).pop();
          }
          // else{
          return Center(child: const CircularProgressIndicator());
          // }
          // return context;


        }
    );
  }

  login(String email, password) async {
    userModel data = userModel(email: email, password: password);
    showDialoge(context);
    var provider = Provider.of<DataClass>(context, listen: false);
    await provider.postDataLogin(data);
    if (provider.json_data['success'] == true) {

      setState(() {
        islogin = true;
      });
      String userid = provider.json_data['data']['userid'];
      SharedPreferences WholesalerShared = await SharedPreferences.getInstance();
      var dataWholeSaler = {
        "success":true,
        "loginAs" : "w",
        "data": {
          "_id": "63c1bd96cef55b7066be1e45",
          "userid": provider.json_data['data']['userid'],
          "fullname": provider.json_data['data']['fullname'],
          "email": provider.json_data['data']['email'],
          "phone": provider.json_data['data']['phone'],
          "password": provider.json_data['data']['password'],
          "addedon": provider.json_data['data']['addedon'],
          "__v": 0
        }
      };
      print("SHARED DATA --- " + jsonEncode(dataWholeSaler));
      WholesalerShared.setString("WholeSaler", jsonEncode(dataWholeSaler));
      UserID.updateJsonDataWholesaler();
      final timer = Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            WholesalerProfile()), (Route<dynamic> route) => false);
      }
      );
    } else {
      _showDialog(context);
    }
  }



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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login to your\naccount',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 200,
                      height: 100,
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
                      InputField(
                        hintText: 'Email',
                        suffixIcon: SizedBox(),
                        controller: emailController,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      InputField(
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: !passwordVisible,
                        suffixIcon: IconButton(
                          color: textGrey,
                          splashRadius: 1,
                          icon: Icon(passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: togglePassword,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Text(
                    'Forget password ?',
                    style: regular16pt.copyWith(color: primaryBlue),
                  ),
                  onTap:(){
                   Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SendOTP()));
                  } ,
                ),
                SizedBox(
                  height: 32,
                ),
                CustomPrimaryButton(
                  buttonColor: Color(0xfffbfbfb),
                  textValue: 'Login',
                  textColor: textBlack,
                  onPressed: () {
                    login(emailController.text ,passwordController.text);
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Text(
                        'Register',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Invalid User"),
        content: Text("Enter Correct Details Thank You!"),
        actions: <Widget>[
          ElevatedButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}




