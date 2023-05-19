import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/screens/CustomerPanel/Shippment_customer.dart';
import 'package:shop_app/screens/Shippment.dart';
import 'package:shop_app/widgets/cart_item.dart';

import '../../routes/routes.dart';

class CartScreenCustomer extends StatefulWidget {
  const CartScreenCustomer({Key? key}) : super(key: key);

  @override
  State<CartScreenCustomer> createState() => _CartScreenCustomerState();
}

class _CartScreenCustomerState extends State<CartScreenCustomer> {
  bool _isordered = false;
  Widget alertDialog() {
    return const AlertDialog(
      title: Center(
        child: Text("Order Accepted!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    var cart = Provider.of<CartProvider>(context);
    var order = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 22),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {

                cart.delete_prefrence();
                //cart.clearApiCart('r1');
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>ShippingScreenCustomer()));


              },
              child: const Text(
                "ORDER NOW",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(0),
                child: SizedBox(
                  height: _screenSize.height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 4, left: 15.0),
                        child: Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Chip(
                          backgroundColor: Colors.indigo,
                          label: Text(
                            cart.totalAmount.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: cart.cartItem.isEmpty
                  ? const Center(
                      child: Text(
                        "Cart's Empty",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cart.cartItem.length,
                      itemBuilder: (context, index) => CartItem(
                        pid: cart.cartItem.values.toList()[index].pid,
                          productid: cart.cartItem.values.toList()[index].id,
                          productName:
                              cart.cartItem.values.toList()[index].productName,
                          price: cart.cartItem.values.toList()[index].price,
                          imgUrl: cart.cartItem.values.toList()[index].imgUrl,
                          quantity:
                              cart.cartItem.values.toList()[index].quantity),
                    ),
            ),
          ],
        ),
        Positioned(
          child: Center(
            child: _isordered ? alertDialog() : Container(),
          ),
        ),
      ]),
    );
  }
}
