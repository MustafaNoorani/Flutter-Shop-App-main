import 'package:flutter/material.dart';

class Cart {
  String id;
  String itemid;
  String productName;
  int price;
  String imgUrl;
  int quantity;

  Cart({
    required this.id,
    required this.itemid,
    required this.productName,
    required this.imgUrl,

    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.id;
    return data;
  }
}