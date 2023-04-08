import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/product_item.dart';
//import 'package:shop_app/screens/user_products/update_product.dart';

import '../provider/product_provider.dart';
import '../routes/routes.dart';

class UserProductsItem extends StatefulWidget {

  String id;
  String productName;
  int price;
  String imgUrl;
  bool status;

  UserProductsItem(
      {required this.productName, required this.price, required this.imgUrl,required this.id,required this.status});

  @override
  State<UserProductsItem> createState() => _UserProductsItemState();
}

class _UserProductsItemState extends State<UserProductsItem> {
  bool _Mode = true;

  @override
  Widget build(BuildContext context) {
    //_Mode=widget.status;
    //  _Mode = widget.status;
    Size _screenSize = MediaQuery.of(context).size;
    var _product = Provider
        .of<ProductProvider>(context);
    return ListTile(
      leading: SizedBox(
        width: _screenSize.width * 0.15,
        child: Image.memory(
          base64.decode(widget.imgUrl),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        widget.productName,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(widget.price.toString()),
      trailing: SizedBox(
        width: _screenSize.width /2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.updateproduct,
                    arguments: widget.id);
              },
              icon: const Icon(Icons.edit, color: Colors.indigo),
            ),
            Switch(
              // thumb color (round icon)
              activeColor: Colors.green,
              activeTrackColor: Colors.green,
              inactiveThumbColor: Colors.red,
              inactiveTrackColor: Colors.red,
              splashRadius: _screenSize.width * 0.25,
              // boolean variable value
              value: widget.status,
              // changes the state of the switch
              onChanged: (value) {
                setState(() {
                  _product.update_product_status(widget.id, value);
                  widget.status=value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}