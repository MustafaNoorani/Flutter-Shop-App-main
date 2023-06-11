import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/provider/product_provider.dart';
import '../models/cart.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orderItem = [];
  List<Order> get orderItem {
    return [..._orderItem];
  }
  final Map<String, Cart> _cartItems = {};
  Map<String, Cart> get cartItem {
    return {..._cartItems};
  }
  Map<String, Cart> quantity = {};
  //Map<dynamic,productid> updatelist={};
  add_order(var  userid, orderitems , phonenumber, cnic , deliveryaddress,paymentmethod) async {
    Order data = Order(
        totalAmount: 0,
        userid: userid,
        orderItems: orderitems,
        phonenumber: phonenumber,
        cnic: cnic,
        deliveryAddress: deliveryaddress,
        paymentmethod: paymentmethod,
        dateTime: "",
        id: ""

    );
    print(orderitems);
    print(userid);
    try {
      var response=
      await http.post(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/order/addorder"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
      print(response.body);

    }
    catch (e) {
      print(e.toString());
    }
  }
  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((key, eachItem) {
      total = total + eachItem.price * eachItem.quantity;
    });
    return total;
  }
  Future<List<Order>>  view_order(String userid) async {
    try {
      http.Response response =
      await http.get(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/order/"+userid+"/vieworder"),
          headers: {"Content-Type": "application/json"});
      var myMap = jsonDecode(response.body);
      print(myMap);
      _cartItems.clear();
      _orderItem.clear();
      var dataSet = myMap["data"];
       print(dataSet);
      getDataSet(dataSet);
      return _orderItem;
    }
    catch (e) {
      print(e.toString());
      return[];
    }
  }
  Future<List<Order>> view_order_vendor(String userid) async {
    try {
      http.Response response =
      await http.get(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/order/"+userid+"/vieworder123"),
          headers: {"Content-Type": "application/json"});
      var myMap = jsonDecode(response.body);
      //print(myMap);
      _cartItems.clear();
      _orderItem.clear();
      var dataSet = myMap["data"];
      //print(dataSet);
      getDataSet(dataSet);
      //print("habb$_orderItem");
      return _orderItem;
      // print(getDataSet(dataSet));

    }
    catch (e) {
      return [];
    }
  }

  getDataSet(List<dynamic> dataSet) {
    var myItems = dataSet.forEach((data) {
      var userId = data["userid"];
      _cartItems.clear();
      (data["items"] as List).forEach((item) {
        if (item["product"].length > 0) {
          var product = item["product"][0];
          String productId = product["productid"];
          if (productId != '') {
            if (_cartItems.containsKey(productId)) {
              _cartItems.update(productId, (existingItem) {
                return Cart(
                  pid: existingItem.pid,
                    itemid: existingItem.itemid,
                    id: existingItem.id,
                    productName: existingItem.productName,
                    price: existingItem.price,
                    imgUrl: existingItem.imgUrl,
                    quantity: existingItem.quantity + 1);
              });
            }
            _cartItems.putIfAbsent(
              productId,
                  () =>
                  Cart(
                    pid: product["pid"],
                    itemid: item["cartid"],
                    id: productId,
                    productName: product["productname"],
                    price: product["price"],
                    imgUrl: product["image"],
                    quantity: item["order_quantity"],
                  ),
            );
          }

        }
      });
      if(_cartItems.length>0) {
        _orderItem.insert(
          0,
          Order(
            userid: userId,
            //id: DateTime.now().toString(),
            totalAmount: totalAmount,
            dateTime: data["addedon"],
            orderItems: _cartItems.values.toList(),
            Status:data["status"],
            id:data["orderid"],
            phonenumber: data["phonenumber"],
            cnic: data["cnic"],
            deliveryAddress: data["deliveryAddress"],
          ),
        );
      }
    });

  }
  update_order_status(String orderid,String status) async{
    Order data = Order(orderItems: [], id: orderid, dateTime: "", totalAmount: 0,Status: status);
    print(data.Status);
    try {
      http.Response response =
      await http.put(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/order/updatestatus"
              ""),

          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.tooJson()));
      print(response.body);

    }
    catch (e) {
      print(e.toString());
    }

  }
  void clearApiOrder(String orderid) async {
    try {
      //http.Response response =
      await http.delete(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/order/"+orderid+"/removefromorder"));
      // _cartItems.clear();
    }
    catch(e)
    {print(e.toString());}
  }
  // var retailerid='Default';
  // void getuser()async{
  //   SharedPreferences logindata = await SharedPreferences.getInstance();
  //
  //   var data = logindata.getString("Retailer");
  //   Map decodedjson = jsonDecode(data.toString());
  //   retailerid = decodedjson["userid"];
  //   //print(retailerid);
  //
  // }

}
