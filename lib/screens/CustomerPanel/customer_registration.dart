import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/user_provider.dart';
import 'package:shop_app/screens/CustomerPanel/customer_login.dart';
import '../../provider/user_id_class.dart';
import '../login_registration/input_field.dart';
import '../login_registration/theme.dart';
import '../login_registration/custom_primary_button.dart';

class RegisterScreenCustomer extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreenCustomer> {
  final TextEditingController useridController =
      TextEditingController(text: '');
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  bool isChecked = false;
  bool isRegistered = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  register_Customer(String userid, name, email, password, phonenumber) async {
    userModel data = userModel(
        userid: userid,
        fullname: name,
        email: email,
        phone: phonenumber,
        password: password);
    var provider = Provider.of<DataClassCustomer>(context, listen: false);
    await provider.postDataRegisterCustomer(data);
    if (provider.json_data['success'] == true) {
      _showDialog(context);
      UserID().sendmail("mustafa", "jovin32735@onlcool.com", "SIGN UP", "Welcome to SamjhDar Dukardar\nHappy Surfing..!",emailController.text);


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
                      'Register new\naccount',
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
                        hintText: 'Enter User ID',
                        controller: useridController,
                        suffixIcon: SizedBox(),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      InputField(
                        hintText: 'Enter Your Name',
                        controller: nameController,
                        suffixIcon: SizedBox(),
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
                      SizedBox(
                        height: 32,
                      ),
                      InputField(
                        hintText: 'Email',
                        controller: emailController,
                        suffixIcon: SizedBox(),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      InputField(
                        hintText: 'Enter Phone Number',
                        controller: phoneController,
                        suffixIcon: SizedBox(),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isChecked ? primaryBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(4.0),
                          border: isChecked
                              ? null
                              : Border.all(color: textGrey, width: 1.5),
                        ),
                        width: 20,
                        height: 20,
                        child: isChecked
                            ? Icon(
                                Icons.check,
                                size: 20,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'By creating an account, you agree to our',
                          style: regular16pt.copyWith(color: textGrey),
                        ),
                        Text(
                          'Terms & Conditions',
                          style: regular16pt.copyWith(color: primaryBlue),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                // BlocConsumer<AuthCubit, AuthState>(
                //   listener: (context, state) {
                //     if (state is AuthSuccess) {
                //       Navigator.pushAndRemoveUntil(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => HomeScreen(),
                //           ),
                //               (route) => false);
                //     } else if (state is AuthFailed) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           backgroundColor: Colors.red.shade700,
                //           content: Text(
                //             state.error,
                //           ),
                //         ),
                //       );
                //     }
                //   },
                //   builder: (context, state) {
                //     if (state is AuthLoading) {
                //       return Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }
                //     return CustomPrimaryButton(
                CustomPrimaryButton(
                    buttonColor: primaryBlue,
                    textValue: 'Register',
                    textColor: Colors.white,
                    onPressed: () {
                      register_Customer(
                          useridController.text,
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          phoneController.text);

                    }),

                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      child: Text(
                        'Login',
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
        title: Text("User Message"),
        content: Text("Your Account is Created.."),
        actions: <Widget>[
          ElevatedButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreenCustomer()));
            },
          ),
        ],
      );
    },
  );
}