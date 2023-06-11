// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/WholesalerOrder.dart';
import 'package:shop_app/screens/addnearbyworkshops.dart';
import 'package:shop_app/screens/login_registration/login_reg_screen.dart';
import 'package:shop_app/screens/user_products/predictimage.dart';
import 'package:splashscreen/splashscreen.dart';
import '../main.dart';
import '../provider/order_provider.dart';
import '../provider/user_id_class.dart';
import '../routes/routes.dart';
import '../widgets/profile_listtile.dart';
import 'UpdateUserDetails.dart';

class WholesalerProfile extends StatefulWidget {
  const WholesalerProfile({Key? key}) : super(key: key);
  @override
  State<WholesalerProfile> createState() => _WholesalerProfileState();

}

bool _darkMode = true;
delete_prefrence() async {
  SharedPreferences sharedprefremove = await SharedPreferences.getInstance();
  sharedprefremove.remove("WholeSaler");
  sharedprefremove.remove("myData");
}
class _WholesalerProfileState extends State<WholesalerProfile> {
  String Email= "";
  var username = "";
  @override
  void initState()  {
    super.initState();
    UserID.updateJsonDataWholesaler();
    username =UserID.userid_Wholesaler.toString() ;

  }
  @override
  Widget build(BuildContext context) {
    //var userProvider = Provider.of<DataClass>(context);
    var order = Provider.of<OrderProvider>(context);
    order.view_order_vendor(username);

    //String username = userProvider.us['username'].toString();
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
        elevation: 0.0,
      ),
      body: username != ""  ?
      ListView(
        children: [
          Container(
            height: 210,
            width: double.infinity,
            color: Colors.indigo,
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
                            // primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )),
                          onPressed: () {},
                          child: Text(
                            username ?? "",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          InkWell(
            child: CustomListTile(
              "My Product",
              Icons.read_more,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.userProduct);
            },
          ),
          InkWell(
            child: CustomListTile(
              "Add Workshps",
              Icons.place_outlined,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>AddNearByWorkshops()));
            },
          ),
          InkWell(
            child: CustomListTile(
              "My Order",
              Icons.podcasts_rounded,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>WholeSalerOrder()));
            },
          ),
          InkWell(
            child: CustomListTile(
              "Add by Prediction",
              Icons.read_more_sharp,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>predictimage()));
            },
          ),

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


