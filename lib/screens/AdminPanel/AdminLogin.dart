import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/AdminPanel/AdminDashborad.dart';
import '../login_registration/input_field.dart';
import '../login_registration/theme.dart';
import '../login_registration/custom_primary_button.dart';

class LoginScreenAdmin extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenAdmin> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
  TextEditingController(text: '');

  bool passwordVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  bool islogin = false;

  void showDialoge(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          print(islogin);
          if (islogin == true) {
            Navigator.of(context).pop();
          }
          // else{
          return Center(child: const CircularProgressIndicator());
          // }
          // return context;
        });
  }

  Future login(String email, password) async {
    showDialoge(context);
    if(email=='admin' && password=='admin' || email=='Admin' && password=='Admin'){
      setState(() {
        islogin==true;
      });
      Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            Admin_Dashboard()), (Route<dynamic> route) => false);
      });
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
                  height: 32,
                ),
                SizedBox(
                  height: 32,
                ),
                CustomPrimaryButton(
                    buttonColor: Color(0xfffbfbfb),
                    textValue: 'Login',
                    textColor: textBlack,
                    onPressed: () {
                      login(emailController.text, passwordController.text);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void ShowDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(child: const CircularProgressIndicator());
      });
}

void _showDialog(BuildContext context) {
  //Navigator.of(context).pop();
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