
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login_registration/input_field.dart';
import '../login_registration/theme.dart';
import '../login_registration/custom_primary_button.dart';
import 'customer_login.dart';


class changepassord extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<changepassord> {
  final TextEditingController passwordController = TextEditingController(text: '');
  final TextEditingController confirmpassController =
  TextEditingController(text: '');

  bool passwordVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void _changepassword(String useremail,) async{
    if(passwordController.text.toString()==confirmpassController.text.toString())
      {
        var provider = Provider.of<DataClassCustomer>(context, listen: false);
        provider.updatepassword(useremail, passwordController.text.toString());
        __showDialog(context);
      }
    else
      {
        _showDialog(context);
      }

  }

  bool islogin = false;


  @override
  Widget build(BuildContext context) {
    String useremail = ModalRoute.of(context)!.settings.arguments as String;
    print(useremail);
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
                      'Change Password',
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
                      SizedBox(
                        height: 32,
                      ),
                  InputField(
                    hintText: 'Confirm Password',
                    controller: confirmpassController,
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
                    textValue: 'Change password',
                    textColor: textBlack,
                    onPressed: () {
                      _changepassword(useremail);
                      //verifyotp();
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
        title: Text("Invalid Password"),
        content: Text("Enter Correct password Thank You!"),
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
void __showDialog(BuildContext context) {
  //Navigator.of(context).pop();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Change Password"),
        content: Text("Your password is changed \n Thank You!"),
        actions: <Widget>[
          ElevatedButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  LoginScreenCustomer()), (Route<dynamic> route) => false);
            },
          ),
        ],
      );
    },
  );
}



