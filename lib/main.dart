import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/provider/user_provider.dart';
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
  var loggedIn = prefs.getString("Retailer") ?? '';
  bool? islogin;
  if (loggedIn != '') {
    var map = jsonDecode(loggedIn);
    if (map['login'] == "true") {
      islogin = true;
    }
  } else {
    islogin = false;
  }
  print(islogin);
  runApp(MyApp(login: islogin));
}

class MyApp extends StatefulWidget {
  bool? login;
  MyApp({Key? key, required this.login}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? islogin;

  @override
  void initState() {
    super.initState();
    islogin = widget.login;
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
              islogin == true ? NavigatorWidget() : WelcomeScreen(),
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
        },
      ),
    );
  }
}
