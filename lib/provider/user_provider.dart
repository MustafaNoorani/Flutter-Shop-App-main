import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class userModel {
  String? userid;
  String? fullname;
  String? email;
  String? phone;
  String? password;

  userModel(
      {this.userid, this.fullname, this.email, this.phone, this.password});

  userModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    return data;
  }
  Map<String, dynamic> updatetoJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    return data;
  }
  Map<String, dynamic> tooJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

Future<http.Response?> register(userModel data) async {
  var jsondata;
  http.Response? response;
  try {
    response = await http.post(
        Uri.parse(
            "https://adorable-blue-frock.cyclic.app/api/user/wholesaler/createaccount"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data));
  } catch (e) {
    print(e.toString());
  }

  return response;
}

Future<http.Response?> login(userModel data) async {
  http.Response? response;
  try {
    response = await http.post(
        Uri.parse(
            "https://adorable-blue-frock.cyclic.app/api/user/wholesaler/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data));
  } catch (e) {
    print(e.toString());
  }

  return response;
}

class DataClass extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  var json_data;
  String userName = " Default ";
  String user = "";

  Future<void> postDataRegister(userModel body) async {
    loading = true;
    notifyListeners();
    http.Response response = (await register(body))!;
    json_data = jsonDecode(response.body);
    if (json_data['success'] == true) {
      print(json_data);
    }
    loading = false;
    notifyListeners();
    return json_data;
  }

  Future<void> postDataLogin(userModel body) async {
    loading = true;
    notifyListeners();
    http.Response response = (await login(body))!;
    json_data = jsonDecode(response.body);
    if (json_data['success'] == true) {
      print(json_data);
    }
    loading = false;
    notifyListeners();
    return json_data;
  }

  Future<void> getData() async {
    print(json_data);
    notifyListeners();
  }

  Future<void> updatedata(
      String id, String phone, String name) async {
    userModel data =
    userModel(userid: id, phone: phone, fullname: name);
    try {
      http.Response response = await http.put(
          Uri.parse(
              "https://adorable-blue-frock.cyclic.app/api/user/wholesaler/updateuser"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.updatetoJson()));
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
