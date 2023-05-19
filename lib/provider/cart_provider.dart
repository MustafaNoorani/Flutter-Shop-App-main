import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/cart.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  final Map<String, Cart> _cartItems = {};
  Map<String,Cart> cartitems= {};
  var temlist = <Map>[];
  Map<String, Cart> get cartItem {
    return {..._cartItems};
  }
  List<String> items=[];
  var itemid;
  var cartitemid;
  int get cartCount {
    return _cartItems.length;
  }

  void removeProduct(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((key, eachItem) {
      total = total + eachItem.price * eachItem.quantity;
    });
    return total;
  }

  void addQuantity(String productId) async {
    _cartItems.update(productId, (existingItem) {
      String a = existingItem.id.toString();
      temlist.forEach((element) {
        print(element['id']);
        if (element['id'].toString() == a) {
          element['quantity'] = element['quantity'] + 1;
        }
      });
      return Cart(
          id: existingItem.id,
          pid: existingItem.pid,
          productName: existingItem.productName,
          price: existingItem.price,
          imgUrl: existingItem.imgUrl,
          quantity: existingItem.quantity + 1, itemid: '');
    });
    // temlist = temlist;
    notifyListeners();
    var sharedpref = await SharedPreferences.getInstance();
    String myData = jsonEncode(temlist);
    sharedpref.setString("myData", myData);
  }

  void removeQuantity(String productId) async {
    _cartItems.update(productId, (existingItem) {
      if (existingItem.quantity == 1) {
        return Cart(
            id: existingItem.id,
            pid: existingItem.pid,
            productName: existingItem.productName,
            price: existingItem.price,
            imgUrl: existingItem.imgUrl,
            quantity: existingItem.quantity, itemid: '');
      } else {
        String a = existingItem.id.toString();
        temlist.forEach((element) {
          //   print(element);
          print(temlist);
          //print(element['id']);
          if (element['id'].toString() == a) {
            element['quantity'] = element['quantity'] - 1;
          }
        });
        return Cart(
            id: existingItem.id,
            pid: existingItem.pid,
            productName: existingItem.productName,
            price: existingItem.price,
            imgUrl: existingItem.imgUrl,
            quantity: existingItem.quantity - 1, itemid: '');
      }
    });
    notifyListeners();
    var sharedpref = await SharedPreferences.getInstance();
    String myData = jsonEncode(temlist);
    sharedpref.setString("myData", myData);
  }
  void addToCart(
      String productId,String ObjectId, String productName, int price, String imgUrl,String pid) async {
    var json;

    if (_cartItems.containsKey(productId)) {
      _cartItems.update(productId, (existingItem) {
        var jsondata = Cart(
            itemid:existingItem.itemid,
            id: existingItem.id,
            pid: existingItem.pid,
            productName: existingItem.productName,
            price: existingItem.price,
            imgUrl: existingItem.imgUrl,
            quantity: existingItem.quantity + 1);

        String a = existingItem.id.toString();
        temlist.forEach((element) {
          //print(element["ObjectId"]);
          if (element['id'].toString() == a) {
            element['quantity'] = existingItem.quantity + 1;
          }
        });
        return jsondata;
      });
    } else {
      _cartItems.putIfAbsent(
        productId,
            () => Cart(
          itemid:"",
          id: productId,
          productName: productName,
          price: price,
          imgUrl: imgUrl,
          quantity: 1,
                pid : pid
        ),
      );
      print(ObjectId);
      json = {
        "id": productId,
        "ObjectId":ObjectId,
        "productName": productName,
        "price": price,
        "imgUrl": imgUrl,
        "quantity": 1,
        "pid":pid
      };
      temlist.add(json);
    }
    notifyListeners();
    var sharedpref = await SharedPreferences.getInstance();
    String myData = jsonEncode(temlist);
    sharedpref.setString("myData", myData);
  }

  void undoSingleProduct(String productId) {
    if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(productId, (existingItem) {
        return Cart(
            itemid:existingItem.itemid ,
            id: existingItem.id,
            pid: existingItem.pid,
            productName: existingItem.productName,
            imgUrl: existingItem.imgUrl,
            price: existingItem.price,
            quantity: existingItem.quantity - 1);
      });
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }
  my_shared_prefrence() async {
    SharedPreferences sharedpref2 = await SharedPreferences.getInstance();
    var null_condition = sharedpref2.getString("myData") ?? "";
    if (null_condition == "") {
      return null_condition;
    } else {
      var name = sharedpref2.getString("myData") ?? "";
      var decodedJson = jsonDecode(name) as List;
      decodedJson.forEach((element) {
        _cartItems.putIfAbsent(
          element['id'],
              () => Cart(
            itemid:"",
            id: element['id'],
            pid: element['pid'],
            productName: element['productName'],
            price: element['price'],
            imgUrl: element['imgUrl'],
            quantity: element['quantity'],
          ),
        );
        var json = {
          "id": element['id'],
          "pid":element['pid'],
          "ObjectId":element['ObjectId'],
          "productName": element['productName'],
          "price": element['price'],
          "imgUrl": element['imgUrl'],
          "quantity": element['quantity']
        };
        temlist.add(json);
      });
      notifyListeners();
    }
  }

  delete_prefrence() async {
    SharedPreferences sharedprefremove = await SharedPreferences.getInstance();
    sharedprefremove.remove("myData");
  }
  add_cart(String  productid,userid) async {
    Cart data = Cart(
        id:productid,
        itemid:"",
        productName:"",
        price:0,
        imgUrl:"",
        quantity:1,
      pid: ""
    );
    try {
      http.Response response =
      await http.post(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/cart/"+userid+"/addtocart"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
      var myMap = jsonDecode(response.body);
      //print(myMap);
      cartitemid = myMap["data"]["_id"];
    }

    catch (e) {
      print(e.toString());
    }
  }
  view_cart(String userid) async {
    try {
      http.Response response =
      await http.get(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/cart/"+userid+"/viewcart"),
          headers: {"Content-Type": "application/json"});
      var myMap = jsonDecode(response.body);
      print(myMap);
      var myItems = myMap["data"]["items"];
      items.clear();
      for (int i = 0; i < myItems.length; i++) {
        var _item = myMap["data"]["items"][i]["_id"];
        var quantity = myMap["data"]["items"][i]["order_quantity"];
        items.insert(i, _item);
      }
     // _cartItems.clear();
      // (myItems as List).forEach((e) {
      //   var itemid = (e["cartid"]);
      //   String productid = (e["product"][0]["_id"]);
      //   String productname=(e["product"][0]["productname"]);
      //   var price=(e["product"][0]["price"]);
      //   String img=(e["product"][0]["image"]);
      //   var quantity=(e["order_quantity"]);
      //   getData(productid,itemid,productname,price,img,quantity);
      // });
     // notifyListeners();
     //  return _cartItems;
    }
    catch (e) {
      print(e.toString());
      return {};
    }
  }
  void clearApiCart(String userid) async {
    try {
      //http.Response response =
      await http.delete(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/cart/"+userid+"/removefromcart"));
     // _cartItems.clear();
    }
    catch(e)
    {print(e.toString());}
  }
  getData(String productid,itemid,productname,price,img,quantity,pid){
    if (_cartItems.containsKey(productid)) {
      _cartItems.update(productid, (existingItem) {
        return Cart(
            itemid: existingItem.itemid,
            id: existingItem.id,
            productName: existingItem.productName,
            price: existingItem.price,
            imgUrl: existingItem.imgUrl,
            pid: existingItem.pid,
            quantity: existingItem.quantity + 1);
      });
    }
    else{
      _cartItems.putIfAbsent(
        productid,
            () =>
            Cart(
              itemid: itemid,
              id:productid,
              pid: pid,
              productName:productname,
              price:price,
              imgUrl:img,
              quantity:quantity,
            ),
      );
    }
    // return _cartItems;

  }
  update_order_quantity(String orderid,int quantity) async {
    Cart data = Cart(id: orderid, itemid:"", productName:"", imgUrl:"", price:0, quantity: quantity,pid: "");
    //print(data.quantity);
    try {
      http.Response response =
      await http.put(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/cart/updatequantity"),

          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.tooJson()));
      print(response.body);
    }
    catch (e) {
      print(e.toString());
    }

  }
  // update_order_status(String orderid,String status) async{
  //   Order data = Order(orderItems: [], id: orderid, dateTime: "", totalAmount: 0,Status: status);
  //   print(data.Status);
  //   try {
  //     http.Response response =
  //     await http.put(
  //         Uri.parse("https://adorable-blue-frock.cyclic.app/api/order/updatestatus"
  //             ""),
  //
  //         headers: {"Content-Type": "application/json"},
  //         body: jsonEncode(data.tooJson()));
  //     print(response.body);
  //
  //   }
  //   catch (e) {
  //     print(e.toString());
  //   }
  //
  // }

}
