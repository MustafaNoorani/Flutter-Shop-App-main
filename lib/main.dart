import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/provider/user_provider.dart';
import 'package:shop_app/provider/user_id_class.dart';
import 'package:shop_app/screens/CustomerPanel/cart_customer.dart';
import 'package:shop_app/screens/CustomerPanel/customer_login.dart';
import 'package:shop_app/screens/CustomerPanel/navigator_customer.dart';
import 'package:shop_app/screens/CustomerPanel/orders_customer.dart';
import 'package:shop_app/screens/WholesalerProfile.dart';
import 'package:shop_app/screens/login_registration/login_reg_screen.dart';
import 'package:shop_app/screens/login_registration/retailer_login.dart';
import 'package:splashscreen/splashscreen.dart';

import './screens/orders.dart';
import 'screens/user_products/UpdateProductDetails.dart';
import 'screens/user_products/add_products.dart';
import './screens/user_products/user_products.dart';
import './provider/order_provider.dart';
import './widgets/navigator.dart';
import './provider/cart_provider.dart';
import './screens/cart.dart';
import './screens/product_details/product_details.dart';
import './provider/product_provider.dart';
import './routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loggedInWholeSaler = prefs.getString("WholeSaler") ?? '';
  var loggedInRetailer = prefs.getString("Retailer") ?? '';
  var loggedInCustomer = prefs.getString("Customer") ?? '';
  bool? islogin;
  String? loginAs;
  if (loggedInWholeSaler != '' && loggedInRetailer == ''&& loggedInCustomer == '') {
    var map = jsonDecode(loggedInWholeSaler);
    if (map['success'] == true) {
      islogin = true;
      loginAs = map['loginAs'];
      UserID.updateJsonDataWholesaler();
    }
  }
  else if (loggedInWholeSaler == '' && loggedInRetailer != '' && loggedInCustomer == '') {
    var map = jsonDecode(loggedInRetailer);
    if (map['success'] == true) {
      islogin = true;
      loginAs = map['loginAs'];
      UserID.updateJsonDataRetailer();
    }
  }
    else if (loggedInWholeSaler == '' && loggedInRetailer == '' &&
        loggedInCustomer != '') {
      var map = jsonDecode(loggedInCustomer);
      if (map['success'] == true) {
        islogin = true;
        loginAs = map['loginAs'];
        UserID.updateJsonDataCustomer();
      }
    }


  else {
    islogin = false;
    loginAs = null;
  }
  print(islogin);
  runApp(MyApp(login: islogin , loginAs: loginAs,));
}

class MyApp extends StatefulWidget {
  bool? login;
  String? loginAs;

  MyApp({Key? key, required this.login , required this.loginAs}) : super(key: key);


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? islogin;
  String? loginAs;
  @override
  void initState() {
    super.initState();
    islogin = widget.login;
    loginAs = widget.loginAs;
    // if (islogin == true){
    //   Provider.of<CartProvxider_Shared>(context, listen: false)
    //       .my_shared_prefrence();
    // }
    print(widget.login);

  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataClass(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClassRetailer(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClassCustomer(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zulu Shop',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home:  SplashScreen(
          seconds: 3,
          navigateAfterSeconds:
          islogin == true && loginAs == 'w' ? WholesalerProfile() :  islogin == true && loginAs == 'r' ?
          NavigatorWidget() : islogin == true && loginAs == 'c' ? NavigatorWidgetCustomer() : WelcomeScreen() ,
          title: new Text(
            'SplashScreen Example',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white),
          ),
          backgroundColor: Colors.lightBlue[200],
        ),
        // const NavigatorWidget(),
        routes: {
          Routes.productDetails: (context) => const ProductDetails(),
          Routes.cartScreen: (context) => const CartScreen(),
          Routes.orderScreen: (context) => const OrderScreen(),
          Routes.userProduct: (context) =>const UserProductsScreen(),
          Routes.addUserProduct: (context)=> const AddUserProduct(),
          Routes.updateproduct: (context)=> const UpdateProduct(),
          Routes.navigator: (context)=> const NavigatorWidget(),
          Routes.customernavigator: (context)=> const NavigatorWidgetCustomer(),
          Routes.cartScreenCustomer: (context)=> const CartScreenCustomer(),
          Routes.orderScreenCustomer: (context)=> const OrderScreenCustomer(),
        },
      ),
    );
  }
}
