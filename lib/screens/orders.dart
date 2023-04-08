import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../models/order.dart';
import '../provider/order_provider.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}


class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    var order = Provider.of<OrderProvider>(context);
    var retailerid=order.retailerid;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Orders Summary",
            style: TextStyle(fontSize: 22),
          ),
        ),
        body: FutureBuilder<List<Order>>(
          future: order.view_order(retailerid),
          builder: (context, snapshot) {
            //print(snapshot.data);
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return OrderItem(order: snapshot.data![index]);
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
               }
            else if (snapshot.data!.length < 0) {
                return const Center(
                  child: Text(
                    "Nothing Ordered Yet!",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.indigo,
                        fontWeight: FontWeight.w500),
                  ),
                );
              }

              // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        )

      // ListView.builder(
      //         itemCount: order.orderItem.length,
      //         itemBuilder: (context, index) {
      //           return OrderItem(order: order.orderItem[index]);
      //         }),
    );
  }
}
