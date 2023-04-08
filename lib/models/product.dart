import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {

  bool status;
  String? vendorid;
  int price;
  int quantity;
  String? description;
  String? addedon;
  String? categoryname;
  String id;
  String pid;
  String productName;
  String imageUrl;
  bool isFavorite;

  Product(
      {
        this.vendorid,
        required this.id,
        this.status=false,
        this.quantity=0,
        this.description,
        this.addedon,
        this.categoryname,
        this.pid="",
        required this.productName,
        required this.price,
        required this.imageUrl,
        this.isFavorite = false,
      });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorid'] = this.vendorid;
    data['productId'] = this.id;
    data['Status'] = this.status;
    data['categoryname'] = this.categoryname;
    data['productname'] = this.productName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['image'] = this.imageUrl;
    return data;
  }

  void isFavoritePressed() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}