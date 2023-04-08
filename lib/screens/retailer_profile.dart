// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shop_app/screens/user_products/predictimage.dart';
import 'package:shop_app/screens/login_registration/login_reg_screen.dart';
import 'package:shop_app/screens/login_registration/wholesaler_registration.dart';
import '../provider/order_provider.dart';
import '../provider/product_provider.dart';
import '../routes/routes.dart';
import '../widgets/profile_listtile.dart';

class RetailerProfile extends StatefulWidget {
  const RetailerProfile({Key? key}) : super(key: key);
  @override
  State<RetailerProfile> createState() => _RetailerProfileState();

}

bool _darkMode = true;

class _RetailerProfileState extends State<RetailerProfile> {
  @override
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }
  // String username= "";
  // String Email= "";
  // String userid= "";
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     Provider.of<DataClass>(context, listen: false).getData();
  //     var provider = Provider.of<DataClass>(context, listen: false);
  //     userid = (provider.json_data['data']['userdata']);
  //     Provider.of<OrderProvider>(context, listen: false).view_order_vendor(userid);
  //     //Provider.of<ProductProvider>(context, listen: false).getAllTodoswholesaler(userid);
  //
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    // var userProvider = Provider.of<DataClass>(context);
    //var retailerProvider = Provider.of<DataClassRetailer>(context);

    // setState(() {
    //
    //     username = (userProvider.json_data['data']['fullname']);
    //     Email = (userProvider.json_data['data']['email']);
    //   });

    //String username = userProvider.us['username'].toString();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 0,
          elevation: 0.0,
        ),
        body: ListView(
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
                              // primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                )),
                            onPressed: () {},
                            child: Text(
                              // username ?? "",
                              "",
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
                "My Order",
                Icons.favorite_outline,
                Icons.keyboard_arrow_right_outlined,
              ),
              onTap: () {
                //Navigator.of(context).pushNamed(Routes.wholesalerorder);
              },
            ),

            InkWell(
              child: CustomListTile(
                "Setting",
                Icons.settings,
                Icons.keyboard_arrow_right_outlined,
              ),
              onTap: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) =>UpdateUserDetails()));
              },
            ),
            // SwitchListTile(
            //   value: _darkMode,
            //   title: Text(
            //     ' Night Mode',
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            //   secondary: Padding(
            //     padding: const EdgeInsets.all(9.0),
            //     child: Icon(Icons.dark_mode),
            //   ),
            //   onChanged: (newValue) {
            //     setState(() {
            //       _darkMode = newValue;
            //     });
            //   },
            //   visualDensity: VisualDensity.adaptivePlatformDensity,
            //   // switchType: SwitchType.material,
            //   activeColor: Colors.indigo,
            // ),
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
                // subtitle: Text(Email??"Registered to example@gmail.com"),
                subtitle: Text("Registered to example@gmail.com"),
              ),
              onTap: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
            ),
            InkWell(

                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 15, bottom: 14),
                  child: Text(
                    "Product Add by Model",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap:() {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => predictimage()));
                  // }
                } ),
            // CustomListTile(
            //   "Help",
            //   Icons.space_bar_rounded,
            //   Icons.keyboard_arrow_right_outlined,
            // ),
            // CustomListTile(
            //   "About us",
            //   Icons.person_outline,
            //   Icons.keyboard_arrow_right_outlined,
            // ),
            // CustomListTile(
            //   "Contact us",
            //   Icons.message,
            //   Icons.keyboard_arrow_right_outlined,
            // ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "SamajhDaar Dukandar 1.0",
                style: TextStyle(color: Colors.blueGrey, fontSize: 15),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}



