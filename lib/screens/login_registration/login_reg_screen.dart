import 'package:flutter/material.dart';
import 'package:shop_app/screens/AdminPanel/AdminLogin.dart';
import 'package:shop_app/screens/CustomerPanel/customer_login.dart';
import 'package:shop_app/screens/login_registration/WholeSaler_login.dart';
import 'package:shop_app/screens/login_registration/retailer_login.dart';
import 'package:shop_app/screens/login_registration/theme.dart';
import './custom_button_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/accent.png',
            height: 150,
          ),
          const SizedBox(height: 20),
          const Text(
            "Welcome!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Please login or signup",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          CustomButton(
            color: Colors.black,
            textColor: Colors.white,
            text: "Login As WholeSaler",
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          CustomButton(
            color: Colors.white,
            textColor: Colors.black,
            text: "Login As Retailer",
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreenRetailer(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          CustomButton(
            color: Colors.black,
            textColor: Colors.white,
            text: "Login As Customer",
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreenCustomer(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: const SizedBox(height: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "please click here for admin login ",
                style: regular16pt.copyWith(color: textGrey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginScreenAdmin()));
                },
                child: Text(
                  'Sign In',
                  style: regular16pt.copyWith(color: primaryBlue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
