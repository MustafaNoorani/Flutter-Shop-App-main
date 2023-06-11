import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/routes/routes.dart';
import '../../provider/cart_provider.dart';
import '../../provider/user_id_class.dart';
import '../login_registration//input_field.dart';
import '../login_registration/theme.dart';
import '../login_registration/custom_primary_button.dart';



class ShippingScreenCustomer extends StatefulWidget {
  @override
  _ShippingScreenCustomerState createState() => _ShippingScreenCustomerState();
}

class _ShippingScreenCustomerState extends State<ShippingScreenCustomer> {
  @override
  String Email= "";
  var username;
  var shippingData;
  @override
  void initState()  {
    UserID.updateJsonDataCustomer();
    OrderShared.my_shared_prefrence_order_getData();
    super.initState();
    setState(() {
      username = UserID.userid_Customer;
      if(OrderShared.json_order_data != null){
        phoneController.text  = OrderShared.json_order_data!["phoneNo"]??"";
        cnicController.text = OrderShared.json_order_data!["fulladdress"]??"";
        fulladdressController.text = OrderShared.json_order_data!["cnic"]??"";
        cityController.text = OrderShared.json_order_data!["city"]??"";}

    });

    Provider.of<CartProvider>(context,listen: false).view_cart(username);
  }

  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController cnicController = TextEditingController(text:'');
  final TextEditingController fulladdressController = TextEditingController(text:'');
  final TextEditingController cityController = TextEditingController(text:'');
  String payment = "";
  @override
  Widget build(BuildContext context) {
    bool _isordered = false;
    Size _screenSize = MediaQuery.of(context).size;
    Provider.of<CartProvider>(context,listen: false).view_cart(username);
    var cart = Provider.of<CartProvider>(context);
    var order = Provider.of<OrderProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:username != null && username != '' ?
      SingleChildScrollView(
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

                  ],
                ),
                CustomPrimaryButton(
                  buttonColor: Color(0xfffbfbfb),
                  textValue: 'Confirm Order',
                  textColor: textBlack,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Order Placed successfully",
                          style: TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                    cart.delete_prefrence();
                    cart.clearApiCart(username);
                    order.add_order(username,cart.items,phoneController.text,cnicController.text,fulladdressController.text,payment.toString());
                    setState(() {
                      _isordered = !_isordered;
                    });
                    Timer(const Duration(seconds: 1), () => setState(() {
                      _isordered = !_isordered;

                      Navigator.of(context).pushReplacementNamed(Routes.orderScreenCustomer);
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      ): CircularProgressIndicator(),
    );

  }
}


class OrderShared{
  static Map? json_order_data;

  static my_shared_prefrence_order(String phone,cnic,fulladdress,city) async {
    SharedPreferences sharedpref_order= await SharedPreferences.getInstance();
    var json={
      "phoneNo":phone,
      "cnic":cnic,
      "fulladdress":fulladdress,
      "city" : city
    };
    String myShipping = jsonEncode(json);
    print(json_order_data);
    sharedpref_order.setString("shipping", myShipping);
  }
  static Future<void> my_shared_prefrence_order_getData() async {
    SharedPreferences sharedpref_order= await SharedPreferences.getInstance();
    String jsonShip = sharedpref_order.getString("shipping") ?? '';
    var json_data = jsonDecode(jsonShip);
    json_order_data = json_data;

    return json_data;


  }

}


