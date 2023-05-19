import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/provider/user_id_class.dart';
import 'package:shop_app/provider/user_provider.dart';
import 'package:shop_app/screens/login_registration/retailer_registration.dart';
import 'package:shop_app/screens/login_registration/wholesaler_registration.dart';
import '../../provider/cart_provider.dart';
import '../../provider/order_provider.dart';
import '../../provider/product_provider.dart';
import './input_field.dart';
import './theme.dart';
import './custom_primary_button.dart';
import '../../widgets/navigator.dart';
import 'package:http/http.dart' as http;

class LoginScreenRetailer extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenRetailer> {
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
    userModel data = userModel(email: email, password: password);
    showDialoge(context);
    var provider = Provider.of<DataClassRetailer>(context, listen: false);
    await provider.postDataLoginRetailer(data);
    if (provider.json_data['success'] == true) {
      setState(() {
        islogin = true;
      });
      String userid = provider.json_data['data']['userid'];
      //Product And Cart Word
      // Provider.of<ProductProvider>(context, listen: false).getAllTodos();
      // Provider.of<CartProvider>(context, listen: false).view_cart(userid);
      SharedPreferences RetailerShared = await SharedPreferences.getInstance();

      var dataRetailer = {
        "success":true,
        "loginAs" : "r",

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
      RetailerShared.setString("Retailer", jsonEncode(dataRetailer));
      UserID.updateJsonDataRetailer();
      final timer = Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            NavigatorWidget()), (Route<dynamic> route) => false);
      });
    } else {
      _showDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataClassRetailer>(context, listen: false);
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
                                builder: (context) =>
                                    RegisterScreenRetailer()));
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

Future<http.Response?> registerRetailer(userModel data) async {
  http.Response? response;
  try {
    response = await http.post(
        Uri.parse(
            "https://adorable-blue-frock.cyclic.app/api/user/retailer/createaccount"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data));
  } catch (e) {
    print(e.toString());
  }

  return response;
}

Future<http.Response?> loginRetailer(userModel data) async {
  http.Response? response;
  try {
    response = await http.post(
        Uri.parse(
            "https://adorable-blue-frock.cyclic.app/api/user/retailer/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data));
  } catch (e) {
    print(e.toString());
  }

  return response;
}

class DataClassRetailer extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  var json_data;
  String userName = " Default ";
  String user = "retailer";

  Future<void> postDataRegisterRetailer(userModel body) async {
    loading = true;
    notifyListeners();
    http.Response response = (await registerRetailer(body))!;
    json_data = jsonDecode(response.body);
    if (json_data['success'] == true) {
      print(json_data);
    }
    loading = false;
    notifyListeners();
    return json_data;
  }

  Future<void> postDataLoginRetailer(userModel body) async {
    loading = true;
    notifyListeners();
    http.Response response = (await loginRetailer(body))!;
    json_data = jsonDecode(response.body);
    if (json_data['success'] == true) {
      print(json_data);
    }
    loading = false;
    notifyListeners();
    return json_data;
  }

  Future<void> getData() async {
    print(json_data);
    notifyListeners();
  }

  Future<void> updatedata(
      String id, String password, String phone, String name) async {
    userModel data =
    userModel(userid: id, password: password, phone: phone, fullname: name);
    try {
      http.Response response = await http.put(
          Uri.parse(
              "https://adorable-blue-frock.cyclic.app/api/user/retailer/updateuser"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
