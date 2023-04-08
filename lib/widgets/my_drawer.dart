import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import 'navigator.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isloading=true;

  void showDialoge(BuildContext context)
  {
    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          print(isloading);
          if(isloading==false){
            Navigator.of(context).pop();
          }
          // else{
          return Center(child: const CircularProgressIndicator());
          // }
          // return context;


        }
    );
  }

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
            Provider.of<ProductProvider>(context, listen: false).getAll('all','','');
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) => NavigatorWidget()), (Route route) => false);
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
              Provider.of<ProductProvider>(context, listen: false).getAll('cat','','Body Parts');
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) => NavigatorWidget()), (Route route) => false);
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
              Provider.of<ProductProvider>(context, listen: false).getAll('cat','','Electrical Parts');
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) => NavigatorWidget()), (Route route) => false);

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
              Provider.of<ProductProvider>(context, listen: false).getAll('cat','','Engine Parts');
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) => NavigatorWidget()), (Route route) => false);

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
