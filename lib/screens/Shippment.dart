import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/routes/routes.dart';
import '../../provider/cart_provider.dart';
import './login_registration//input_field.dart';
import './login_registration/theme.dart';
import './login_registration/custom_primary_button.dart';



class ShippingScreen extends StatefulWidget {
  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {

  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController cnicController = TextEditingController(text:'');
  final TextEditingController fulladdressController = TextEditingController(text:'');
  final TextEditingController cityController = TextEditingController(text:'');
  String payment = "";
  var retailerid;
  void getuser()async{
    SharedPreferences logindata = await SharedPreferences.getInstance();

    var data = logindata.getString("Retailer");
    Map decodedjson = jsonDecode(data.toString());
    retailerid = decodedjson["userid"];
    print(retailerid);

  }
  @override
  Widget build(BuildContext context) {
    bool _isordered = false;
    Widget alertDialog() {
      return const AlertDialog(
        title: Center(
          child: Text("Order Accepted!"),
        ),
      );
    }
    getuser();
    Size _screenSize = MediaQuery.of(context).size;
    var cart = Provider.of<CartProvider>(context);
    var order = Provider.of<OrderProvider>(context);
    // var user = Provider.of<DataClassRetailer>(context);
    // String userId= "Default";
    // userId = (user.json_data['data']['userid']);


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
                      'Enter Shipping Details',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    SizedBox(
                      height: 20,
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
                        hintText: 'Phone Number',
                        suffixIcon: SizedBox(),
                        controller: phoneController,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      InputField(
                        hintText: 'CNIC',
                        suffixIcon: SizedBox(),
                        controller: cnicController,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      InputField(
                        hintText: 'Full Address',
                        suffixIcon: SizedBox(),
                        controller: fulladdressController,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      InputField(
                        hintText: 'City',
                        suffixIcon: SizedBox(),
                        controller: cityController,
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                    "Select Payment Option",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 15)
                ),
                SizedBox(
                  height: 22,
                ),
                Column(
                  children: [

                    RadioListTile(
                      title: Text("Cash On Delevery"),
                      value: "cod",
                      groupValue: payment,
                      onChanged: (value){
                        setState(() {
                          payment = value.toString();
                          print(payment);
                        });
                      },
                    ),

                    RadioListTile(
                      title: Text("Online Payment"),
                      value: "online",
                      groupValue: payment,
                      onChanged: (value){
                        setState(() {
                          payment = value.toString();
                          print(payment);
                        });
                      },
                    ),
                  ],
                ),
                CustomPrimaryButton(
                  buttonColor: Color(0xfffbfbfb),
                  textValue: 'Confirm Order',
                  textColor: textBlack,
                  onPressed: () {
                    //order.add_order(retailerid,cart.items,phoneController.text,cnicController.text,fulladdressController.text,payment.toString());
                    //cart.clearCart(userId);
                    //order.view_order(userId);
                    setState(() {
                      _isordered = !_isordered;
                    });
                    Timer(const Duration(seconds: 1), () => setState(() {
                      _isordered = !_isordered;
                      Navigator.of(context).pushReplacementNamed(Routes.orderScreen);
                    }));
                  },
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
            },
          ),
        ],
      );
    },
  );
}



