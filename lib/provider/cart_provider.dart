import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/cart.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  final Map<String, Cart> _cartItems = {};
  var temlist = <Map>[];
  Map<String, Cart> get cartItem {
    return {..._cartItems};
  }

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
      String productId, String productName, int price, String imgUrl) async {
    var json;

    if (_cartItems.containsKey(productId)) {
      _cartItems.update(productId, (existingItem) {
        var jsondata = Cart(
            itemid:existingItem.itemid,
            id: existingItem.id,
            productName: existingItem.productName,
            price: existingItem.price,
            imgUrl: existingItem.imgUrl,
            quantity: existingItem.quantity + 1);

        String a = existingItem.id.toString();
        temlist.forEach((element) {
          print(element['id']);
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
        ),
      );
      json = {
        "id": productId,
        "productName": productName,
        "price": price,
        "imgUrl": imgUrl,
        "quantity": 1
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
            productName: element['productName'],
            price: element['price'],
            imgUrl: element['imgUrl'],
            quantity: element['quantity'],
          ),
        );
        var json = {
          "id": element['id'],
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
        quantity:0
    );
    try {
      http.Response response =
      await http.post(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/cart/"+userid+"/addtocart"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
    }

    catch (e) {
      print(e.toString());
    }
  }

}
