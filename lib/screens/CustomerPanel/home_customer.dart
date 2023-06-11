import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/CustomerPanel/my_drawer_customer.dart';
import 'package:shop_app/screens/CustomerPanel/product_item_Customer.dart';
import 'package:shop_app/widgets/my_drawer.dart';
import '../../models/product.dart';
import '../../provider/cart_provider.dart';
import '../../provider/order_provider.dart';
import '../../provider/product_provider.dart';
import '../../widgets/product_item.dart';
import '../../routes/routes.dart';

class HomePageCustomer extends StatefulWidget {
  const HomePageCustomer({Key? key}) : super(key: key);

  @override
  State<HomePageCustomer> createState() => _HomePageCustomerState();
}

class _HomePageCustomerState extends State<HomePageCustomer> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).my_shared_prefrence();
    // Provider.of<OrderProvider>(context, listen: false).getuser();
  }
  @override

  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
   // var product = Provider.of<ProductProvider>(context);
    var productProvider = Provider.of<ProductProvider>(context);
    //var product = productProvider.items;
    var cart = Provider.of<CartProvider>(context);
    String categoryname = ModalRoute.of(context)!.settings.arguments as String;

    //var order = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Zulu Shop",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 8.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.cartScreenCustomer);
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 28,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Badge(
                    badgeContent: Text(
                      '${cart.cartCount}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    badgeColor: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const MyDrawerCustomer(),
      body: FutureBuilder<List<Product>>(
        future:productProvider.getAllProducts(' ','r',categoryname??" ") ,
        builder: (context, snapshot) {
          //print(snapshot.data);
          if (snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data?.length,
              itemBuilder: (ctx, index) {
                return ProductItemsCustomer(product: snapshot.data![index]);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: _screenSize.width / (_screenSize.height / 1.4),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      )
      // GridView.builder(
      //   padding: const EdgeInsets.all(10),
      //   physics: const BouncingScrollPhysics(),
      //   itemCount: product.length,
      //   itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
      //     value: product[index],
      //     child: const ProductItems(),
      //   ),
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     childAspectRatio: _screenSize.width / (_screenSize.height / 1.4),
      //     mainAxisSpacing: 12,
      //     crossAxisSpacing: 12,
      //   ),
      // ),
    );
  }
}
