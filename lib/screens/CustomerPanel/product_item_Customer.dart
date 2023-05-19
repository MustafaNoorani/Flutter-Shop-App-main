import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:shop_app/screens/login_registration/Retailer_login.dart';
import '../../models/product.dart';
import '../../provider/cart_provider.dart';
import '../../provider/product_provider.dart';
import '../../provider/user_id_class.dart';
import '../../routes/routes.dart';
//import '../CustomerPanel/navigator_customer.dart';


class ProductItemsCustomer extends StatefulWidget {
  Product product;
  //ProductItems({Key? key},) : super(key: key);
  ProductItemsCustomer({Key? key, required this.product}) : super(key: key);


  @override
  State<ProductItemsCustomer> createState() => _ProductItemsCustomerState();
}

class _ProductItemsCustomerState extends State<ProductItemsCustomer> {
  @override
  String Email= "";
  var username;
  @override
  void initState()  {
    UserID.updateJsonDataCustomer();
    super.initState();
    setState(() {
      username = UserID.userid_Customer;
    });
  }


  Widget build(BuildContext context) {
    //String userId="Default";
    Size _screenSize = MediaQuery.of(context).size;
    //var product = Provider.of<Product>(context);
    var cart = Provider.of<CartProvider>(context);
    var products = Provider.of<ProductProvider>(context);
   // var user = Provider.of<DataClassRetailer>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.productDetails,
            arguments: widget.product.id);
      },
      child: username != null && username != '' ?
      Stack(children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: _screenSize.height * 0.025),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: _screenSize.height * 0.135,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: MemoryImage(base64.decode(widget.product.imageUrl)),
                        fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: _screenSize.width * 0.4,
                  child: Text(
                    widget.product.productName,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.5,
                      color: Colors.indigo,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: _screenSize.height * 0.015,
          right: _screenSize.height * 0.015,
          child: InkWell(
            onTap: () {
              widget.product.isFavoritePressed();
              if (widget.product.isFavorite) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Product Added to Favorite!",
                      style: TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 1),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Product Removed from Favorite!",
                      style: TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
            child: Icon(
              widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 25,
              color: Colors.indigo,
            ),
          ),
        ),
        Positioned(
          bottom: _screenSize.height * 0.032,
          right: _screenSize.height * 0.007,
          child: Container(
            height: _screenSize.height * 0.052,
            width: _screenSize.width * 0.11,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: InkWell(
              onTap: () {
                //print(widget.product.pid);
                //print(username);
                cart.add_cart(widget.product.pid,username);
                cart.addToCart(widget.product.id,widget.product.pid,widget.product.productName,widget.product.price, widget.product.imageUrl,widget.product.pid);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 1),
                    content: const Text(
                      "Added to Cart!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    action: SnackBarAction(
                      label: "UNDO",
                      textColor: Colors.white,
                      onPressed: () {
                        cart.undoSingleProduct(widget.product.id);
                      },
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.shopping_cart,
                size: 24,
                color: Colors.indigo,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: _screenSize.height * 0.05,
          left: 20,
          child: Row(
            children: [
              const Text(
                "Rs",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${widget.product.price}",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: _screenSize.height * 0.024,
          left: 20,
          child: Row(
            children: [
              Text(
                "Quantity ",
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
              Text(
                "${widget.product.quantity}",
                style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ]): CircularProgressIndicator(),
    );
  }
}
