import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/CustomerPanel/navigator_customer.dart';
import '../../provider/product_provider.dart';
import '../../routes/routes.dart';
import '../../widgets/navigator.dart';

class MyDrawerCustomer extends StatefulWidget {
  const MyDrawerCustomer({Key? key}) : super(key: key);

  @override
  State<MyDrawerCustomer> createState() => _MyDrawerCustomerState();
}

class _MyDrawerCustomerState extends State<MyDrawerCustomer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              "Zulu Shop",
              style: TextStyle(fontSize: 22),
            ),
          ),
          const Divider(),
          InkWell(
            onTap:()
            { //showDialoge(context);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => NavigatorWidgetCustomer()), (Route route) => false);
             },
            child: const ListTile(
              leading: Icon(
                Icons.sell,
                color: Colors.indigo,
              ),
              title: Text(
                "Shop",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: ()
            {
              Navigator.pushNamed(context, Routes.customernavigator,
                  arguments: 'Body Parts' );
              // Provider.of<ProductProvider>(context, listen: false).getAll('cat','','Body Parts');
              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              //     builder: (context) => NavigatorWidgetCustomer()), (Route route) => false);
            },child: const ListTile(
            leading: Icon(
              Icons.pageview,
              color: Colors.indigo,
            ),
            title: Text(
              'Body Parts',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ),
          const Divider(),
          InkWell(
            onTap: ()
            {
              Navigator.pushNamed(context, Routes.customernavigator,
                  arguments: 'Electrical Parts' );
              // Provider.of<ProductProvider>(context, listen: false).getAll('cat','','Electrical Parts');
              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              //     builder: (context) => NavigatorWidget()), (Route route) => false);

            },
            child: const ListTile(
              leading: Icon(
                Icons.pageview,
                color: Colors.indigo,
              ),
              title: Text(
                'Electrical Parts',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: ()
            {
              Navigator.pushNamed(context, Routes.customernavigator,
                  arguments: 'Engine Parts' );
              // Provider.of<ProductProvider>(context, listen: false).getAll('cat','','Engine Parts');
              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              //     builder: (context) => NavigatorWidget()), (Route route) => false);

            },   child: const ListTile(
            leading: Icon(
              Icons.pageview,
              color: Colors.indigo,
            ),
            title: Text(
              'Engine Parts',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
