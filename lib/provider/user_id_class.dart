
import 'dart:convert';

import 'package:http/http.dart' as http;
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
      //print(json_data['data']['userid']);
      return json_data;
    }

  }
  Future sendmail(String name,String email,String subject,String message,String senderemail)async{
    String url = 'https://api.emailjs.com/api/v1.0/email/send';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
      headers: {"Content-Type": "application/json"},
      body:json.encode( {
      'service_id':'service_w9rrsgg',
        'template_id': 'template_9sexyfk',
        'user_id':'wQoARRZcM6ah5vpi1',
        'template_params':{
        'user_name':name,
          'user_email':email,
          'user_subject':subject,
          'user_message':message,
          'email':senderemail,
        },
      }),
    );
    print(response.body);

  }

}