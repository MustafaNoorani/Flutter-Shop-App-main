import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/provider/user_id_class.dart';
import 'package:shop_app/screens/CustomerPanel/navigator_customer.dart';

import 'package:shop_app/widgets/order_item.dart';

import '../../models/order.dart';
import '../../provider/order_provider.dart';


class OrderScreenCustomer extends StatefulWidget {
  const OrderScreenCustomer({Key? key}) : super(key: key);

  @override
  State<OrderScreenCustomer> createState() => _OrderScreenCustomerState();
}


class _OrderScreenCustomerState extends State<OrderScreenCustomer> {
  String Email= "";
  var username = "";
  @override
  void initState()  {
    super.initState();
    UserID.updateJsonDataCustomer();
    username =UserID.userid_Customer.toString() ;

  }
  @override
  Widget build(BuildContext context) {
    var order = Provider.of<OrderProvider>(context);
    // order.view_order(username);
    // var retailerid=order.retailerid;
    return Scaffold(
        appBar:
        AppBar(
          title: const Text(
            "Orders Summary",
            style: TextStyle(fontSize: 22),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  NavigatorWidgetCustomer()), (Route<dynamic> route) => false)
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
            // else if (snapshot.data?.length == 0) {
            //   return const Center(
            //     child: Text(
            //       "Nothing Ordered Yet!",
            //       style: TextStyle(
            //           fontSize: 20,
            //           color: Colors.indigo,
            //           fontWeight: FontWeight.w500),
            //     ),
            //   );
            // }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ):CircularProgressIndicator()
      // ListView.builder(
      //         itemCount: order.orderItem.length,
      //         itemBuilder: (context, index) {
      //           return OrderItem(order: order.orderItem[index]);
      //         }),
    );
  }
}
