import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../models/order.dart';
import '../provider/order_provider.dart';
import '../provider/user_provider.dart';
import 'login_registration/Retailer_login.dart';
import 'login_registration/wholesaler_registration.dart';
import 'package:shop_app/screens/login_registration/login_reg_screen.dart';

class WholeSalerOrder extends StatefulWidget {
  const WholeSalerOrder({Key? key}) : super(key: key);

  @override
  State<WholeSalerOrder> createState() => _WholeSalerOrderState();
}

class _WholeSalerOrderState extends State<WholeSalerOrder> {
  // void initState() {
  //   super.initState();
  //       var vendor = Provider.of<DataClass>(context, listen: false);
  //       String vendorId = vendor.json_data['data']['userid'];
  //       Provider.of<OrderProvider>(context).view_order_vendor(vendorId);
  // }
  @override
  Widget build(BuildContext context) {
    var vendor = Provider.of<DataClass>(context, listen: false);
    String vendorId = vendor.json_data['data']['userid'];
    var order = Provider.of<OrderProvider>(context);
    order.view_order_vendor(vendorId);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Orders Summary",
            style: TextStyle(fontSize: 22),
          ),
        ),
        body: order.orderItem.isEmpty
            ? const Center(
          child: Text(
            "Nothing Ordered Yet!",
            style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
                fontWeight: FontWeight.w500),
          ),
        )
            : FutureBuilder<List<Order>>(
          future:order.view_order_vendor(vendorId) ,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return   ListView.builder(
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
        )
    );
  }
}
