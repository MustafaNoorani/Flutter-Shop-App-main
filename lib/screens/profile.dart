// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/main.dart';
//import 'package:shop_app/provider/userid_class.dart';
import 'package:shop_app/screens/cart.dart';
import 'package:shop_app/screens/favorite.dart';
import 'package:shop_app/screens/login_registration/login_reg_screen.dart';
import 'package:shop_app/screens/user_products/user_product_retailer.dart';
import 'package:splashscreen/splashscreen.dart';
import '../provider/user_id_class.dart';
import '../widgets/profile_listtile.dart';
import 'UpdateUserDetails.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();

}

bool _darkMode = true;
delete_prefrence() async {
  SharedPreferences sharedprefremove = await SharedPreferences.getInstance();
  sharedprefremove.remove("Retailer");
}


class _ProfileState extends State<Profile> {

  String Email= "";
  var username;
  @override
  void initState()  {
    UserID.updateJsonDataRetailer();
    super.initState();
    setState(() {
      username = UserID.userid_Retailer;
    });
  }
  @override
  Widget build(BuildContext context) {
    // var userProvider = Provider.of<DataClass>(context);
    //  var retailerProvider = Provider.of<DataClassRetailer>(context);
    //
    //  setState(() {
    //           username = (retailerProvider.json_data['data']['fullname']);
    //           Email = (retailerProvider.json_data['data']['email']);
    //    });

    //String username = userProvider.us['username'].toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
        elevation: 0.0,
      ),
      body: username != null && username != '' ?
      ListView(
        children: [
          Container(
            height: 210,
            width: double.infinity,
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/profile.jpg"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      height: 32,
                      width: 140,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )),
                          onPressed: () {},
                          child:
                          Text(
                            username,
                            style: TextStyle(color: Colors.white),
                          ) ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 20, top: 15, bottom: 14),
          //   child: Text(
          //      username ?? "Account",
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //   ),
          // ),
          InkWell(
            child: CustomListTile(
              "My Cart",
              Icons.read_more,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>CartScreen()));

            },
          ),
          InkWell(
            child: CustomListTile(
              "Favorite list",
              Icons.favorite_outline,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>FavoriteScreen()));
            },
          ),
          InkWell(
            child: CustomListTile(
              "Add product and Inventory",
              Icons.favorite_outline,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>UserProductsRetailerScreen()));
            },
          ),
          // CustomListTile(
          //   "Notification",
          //   Icons.notifications_outlined,
          //   Icons.keyboard_arrow_right_outlined,
          // ),
          InkWell(
            child: CustomListTile(
              "Setting",
              Icons.settings,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>UpdateUserDetails()));
            },
          ),
          InkWell(
              child: ListTile(
                title: Text(
                  ("Sign out"),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: (Icon(
                    Icons.logout,
                    size: 25,
                  )),
                ),
                tileColor: Colors.grey.shade100,
                subtitle: Text(Email??"Registered to example@gmail.com"),
              ),
              onTap: () {
                Timer(const Duration(microseconds: 200 ), () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      SplashScreen(
                        seconds: 3,
                        navigateAfterSeconds:
                        MyApp(login: null, loginAs: null),
                        title: new Text(
                          'SplashScreen Example',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                        backgroundColor: Colors.lightBlue[200],
                      ),), (Route<dynamic> route) => false);
                });
                delete_prefrence();
              }

          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "SamajhDaar Dukandar 1.0",
              style: TextStyle(color: Colors.blueGrey, fontSize: 15),
            ),
          ),
          SizedBox(height: 10),
        ],
      ) : CircularProgressIndicator(),
    );
  }
}


