
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/user_provider.dart';
import 'package:shop_app/screens/CustomerPanel/customer_login.dart';
import 'package:shop_app/widgets/wholesaler_item.dart';


class WholesalerListScreen extends StatefulWidget {
  const WholesalerListScreen({Key? key}) : super(key: key);

  @override
  State<WholesalerListScreen> createState() => _WholesalerListScreenState();
}


class _WholesalerListScreenState extends State<WholesalerListScreen> {
  @override
  Widget build(BuildContext context) {
    var wholesaler = Provider.of<DataClassCustomer>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Account List",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: FutureBuilder<List<userModel>>(
        future: wholesaler.getAllCustomer('wholesaler'),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return WholesalerListItem(wholesaler: snapshot.data![index]);
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
