// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:shop_app/screens/AdminPanel/CustomerList.dart';
import 'package:shop_app/screens/AdminPanel/RetailerList.dart';
import 'package:shop_app/screens/AdminPanel/WholesalerList.dart';
import 'package:shop_app/screens/RetailerOrder.dart';
import 'package:shop_app/screens/login_registration/login_reg_screen.dart';

import 'package:shop_app/screens/user_products/user_product_retailer.dart';

import '../../widgets/profile_listtile.dart';

class Admin_Dashboard extends StatefulWidget {
  const Admin_Dashboard({Key? key}) : super(key: key);
  @override
  State<Admin_Dashboard> createState() => _Admin_DashboardState();

}



class _Admin_DashboardState extends State<Admin_Dashboard> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
        elevation: 0.0,
      ),
      body:
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
                            'Admin',
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
              "Wholesaler List",
              Icons.account_circle,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WholesalerListScreen()));
            },
          ),
          InkWell(
            child: CustomListTile(
              "Retailer List",
              Icons.account_circle,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RetailerListScreen()));
            },
          ),
          InkWell(
            child: CustomListTile(
              "Customer List",
              Icons.account_circle,
              Icons.keyboard_arrow_right_outlined,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => CustomerListScreen()));
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
              ),
              onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => WelcomeScreen()), (Route<dynamic> route) => false);

              }

          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: SizedBox(height: 10),
          ),
          Center(
            child: Text(
              "SamajhDaar Dukandar 1.0",
              style: TextStyle(color: Colors.blueGrey, fontSize: 15),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }


}
