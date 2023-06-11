import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/provider/user_id_class.dart';

import '../../models/product.dart';

import '../../routes/routes.dart';
import '../../widgets/user_product_item.dart';


class UserProductsScreen extends StatefulWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {

  String Email= "";
  var username = "";
  @override
  void initState()  {
    super.initState();
    UserID.updateJsonDataWholesaler();
    username =UserID.userid_Wholesaler.toString() ;

  }

  @override
  Widget build(BuildContext context) {

    var _product = Provider
        .of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Products",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.addUserProduct),
              icon: const Icon(Icons.add))
        ],
      ),
      //drawer:  MyDrawer(),
      body:username != "" || username != null  ?
      Padding(
          padding: const EdgeInsets.all(4.0),
          child: FutureBuilder<List<Product>>(
            future:_product.getAllProducts(username,' ', ' '),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          UserProductsItem(
                            id: snapshot.data![index].id,
                            productName: snapshot.data![index].productName,
                            price: snapshot.data![index].price,
                            imgUrl: (snapshot.data![index].imageUrl),
                            status: (snapshot.data![index].status),
                            quantity:(snapshot.data![index].quantity) ,
                          ),
                          const Divider(),
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return Center(child: const CircularProgressIndicator());
            },
          )
      ) : CircularProgressIndicator(),
    );
  }

}






