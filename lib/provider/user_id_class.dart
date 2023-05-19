
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserID {
  static String? userid_Retailer;
  static String? userid_Wholesaler;
  static String? userid_Customer;


  static Future<void> updateJsonDataRetailer() async {
    SharedPreferences RetailerShared = await SharedPreferences.getInstance();
    var loggedIn = RetailerShared.getString("Retailer") ?? '';
    if (loggedIn == ''){
      return null;
    }
    else if (loggedIn != ''){
      var json_data = jsonDecode(loggedIn);
      userid_Retailer = json_data['data']['userid'] ?? '';
      print(json_data['data']['userid']);
      return json_data;
    }

  }
  static Future<void> updateJsonDataWholesaler() async {
    SharedPreferences WholesalerShared = await SharedPreferences.getInstance();
    var loggedIn = WholesalerShared.getString("WholeSaler") ?? '';
    if (loggedIn == ''){
      return null;

    }

    else if (loggedIn != ''){

      var json_data = jsonDecode(loggedIn);
      print(json_data);
      userid_Wholesaler = json_data['data']['userid'] ?? '';
      return json_data;
    }
  }
  static Future<void> updateJsonDataCustomer() async {
    SharedPreferences CustomerShared = await SharedPreferences.getInstance();
    var loggedIn = CustomerShared.getString("Customer") ?? '';
    if (loggedIn == ''){
      return null;
    }
    else if (loggedIn != ''){
      var json_data = jsonDecode(loggedIn);
      userid_Customer = json_data['data']['userid'] ?? '';
      print(json_data['data']['userid']);
      return json_data;
    }

  }

}