import 'package:flutter/material.dart';

class Cart {
  String id;
  String pid;
  String itemid;
  String productName;
  int price;
  String imgUrl;
  int quantity;

  Cart({
    required this.id,
    required this.pid,
    required this.itemid,
    required this.productName,
    required this.imgUrl,

    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.id;
    data['order_quantity'] = this.quantity;
    return data;
  }
  Map<String, dynamic> tooJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartid'] = this.id;
    data['quantity'] = this.quantity;
    return data;
  }
}