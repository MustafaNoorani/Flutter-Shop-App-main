import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/provider/user_id_class.dart';
//import 'package:shop_app/provider/userid_class.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../models/order.dart';
import '../provider/order_provider.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}


class _OrderScreenState extends State<OrderScreen> {
  String Email= "";
  var username = "";
  @override
  void initState()  {
    super.initState();
    UserID.updateJsonDataRetailer();
    username =UserID.userid_Retailer.toString() ;

  }
  @override
  Widget build(BuildContext context) {
    var order = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Orders Summary",
            style: TextStyle(fontSize: 22),
          ),
        ),
        body:username != null && username != '' ?
        FutureBuilder<List<Order>>(
          future: order.view_order(username),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return OrderItem(order: snapshot.data![index]);
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ):CircularProgressIndicator(),
    );
  }
}
