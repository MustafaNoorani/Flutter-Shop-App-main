import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final _service = ProductService();
  List<Product> _items = [];
  //List<Product> get todos => _items;

  Future<void> getAllTodos(List<dynamic> mydata) async {
    final response = await _service.getdata(mydata);
    _items = response;
    //_itemsSerachProduct = _items;
    //notifyListeners();
  }
  List<dynamic> quantitylist = [];

  List<Product> get items {
    return [..._items];
  }
  add_product(String  vendorid,productname, price , quantity ,description, image,category_type,vendor_type ) async {
    Product data = Product(
        vendorid: vendorid,
        productName: productname,
        price: int.parse(price),
        quantity: int.parse(quantity),
        description: description,
        imageUrl: image,
        categoryname: category_type,
        id: "",
      vendor_type: vendor_type,
    );
    print(data.categoryname);
    try {
      //print("try");
      http.Response response =
      await http.post(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/product/add"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
      print(response.body);

    }
    catch (e) {
      print(e.toString());
    }
  }
  Product findById(String id) {
    return _items.firstWhere((prod) {
      return prod.id == id;
    });
  }

  update_product(String productid,int price,int quantity) async{
    Product data = Product(
        id: productid,
        price: price,
        quantity: quantity,
        productName: "",
        imageUrl: ""

    );
    // print(data.categoryname);
    try {
      http.Response response =
      await http.put(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/product/updateproduct"),

          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
      print(response.body);

    }
    catch (e) {
      print(e.toString());
    }

  }
  update_product_status(String productid,bool status) async{
    Product data = Product(
        id: productid,
        status: status,
        productName: "",
        imageUrl: "",
        price: 0
    );
    // print(data.categoryname);
    try {
      http.Response response =
      await http.put(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/product/updatestatus"),

          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
      print(response.body);

    }
    catch (e) {
      print(e.toString());
    }

  }

  List<Product> get selectedFavorite {
    return _items.where((favProducts) {
      return favProducts.isFavorite;
    }).toList();
  }
  // Future<List<Product>> getAllwholesaler(String userid) async {
  //   String url = 'https://adorable-blue-frock.cyclic.app/api/product/'+userid+'/get1';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body) as List;
  //     return _service.getdata(json);
  //   }
  //   return [];
  // }

Future<List<Product>> getAllProducts(String vendorid,String vendortype,String categoryname) async {
  String url = 'https://adorable-blue-frock.cyclic.app/api/product/'+vendorid+'/'+vendortype+'/'+categoryname+'/get1';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body) as List;
    getAllTodos(json);
    return _service.getdata(json);
  }
  return [];
}
  update_product_quantity(String productid, quantity) async {
    Product data = Product(id: productid, productName: "", price: quantity, imageUrl: "");
    try {
      http.Response response =
      await http.put(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/product/updatequantity"),

          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.tooJson()));
      print(response.body);
    }
    catch (e) {
      print(e.toString());
    }

  }
}
class ProductService {
  // Future<List<Product>> getAll() async {
  //   const url = 'https://adorable-blue-frock.cyclic.app/api/product/get';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body) as List;
  //     return getdata(json);
  //
  //   }
  //   return [];
  // }
  Future<List<Product>> getdata(List<dynamic> myData) async {
    final todos = myData.map((e) {
      return Product(
          id: e["productid"],
          pid: e["_id"],
          productName: e["productname"],
          price: e["price"],
          quantity: e["quantity"],
          imageUrl: e["image"],
          status: e["status"],
          vendorid: e["vendorid"]
      );

    }).toList();
    return todos;

  }

  // Future<List<Product>> getAllcategory(String category) async {
  //   String url = 'https://adorable-blue-frock.cyclic.app/api/product/'+category+'/get2';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body) as List;
  //     return getdata(json);
  //   }
  //   return [];
  // }
}