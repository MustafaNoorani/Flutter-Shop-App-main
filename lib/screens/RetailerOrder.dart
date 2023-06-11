
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/user_id_class.dart';

import '../models/order.dart';
import '../provider/order_provider.dart';
import '../widgets/Orderitem_retailer.dart';


class RetailerOrder extends StatefulWidget {
  const RetailerOrder({Key? key}) : super(key: key);

  @override
  State<RetailerOrder> createState() => _RetailerOrderState();
}


class _RetailerOrderState extends State<RetailerOrder> {
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
        future: order.view_order_vendor(username),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return OrderItemvendor(order: snapshot.data![index]);
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
