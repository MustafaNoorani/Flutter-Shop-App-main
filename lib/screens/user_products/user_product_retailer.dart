import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/provider/user_id_class.dart';
import 'package:shop_app/screens/user_products/add_product_retailer.dart';
import '../../models/product.dart';
import '../../widgets/user_product_item.dart';

class UserProductsRetailerScreen extends StatefulWidget {
  const UserProductsRetailerScreen({Key? key}) : super(key: key);

  @override
  State<UserProductsRetailerScreen> createState() => _UserProductsRetailerScreenState();
}

class _UserProductsRetailerScreenState extends State<UserProductsRetailerScreen> {
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>AddUserProductRetailer())),
              icon: const Icon(Icons.add))
        ],
      ),
      //drawer:  MyDrawer(),
      body:username != "" || username != null  ?
      Padding(
          padding: const EdgeInsets.all(4.0),
          child: FutureBuilder<List<Product>>(
            future:_product.getAllProducts(username,' ',' ') ,
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
                            quantity: (snapshot.data![index].quantity),
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






