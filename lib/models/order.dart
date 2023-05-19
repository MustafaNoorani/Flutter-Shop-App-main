import 'package:flutter/foundation.dart';
class Order with ChangeNotifier {
  String? userid;
  List<dynamic> orderItems;
  String? Status;
  String? phonenumber;
  String? cnic;
  String? deliveryAddress;
  String? paymentmethod;
  String id;
  double totalAmount;
  String dateTime;

  Order(
      {this.userid,
        required this.orderItems,
        this.Status,
        this.phonenumber,
        this.cnic,
        this.deliveryAddress,
        this.paymentmethod,
        required this.id,
        required this.dateTime,
        required this.totalAmount
      });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['items'] = this.orderItems;
    data['phonenumber'] = this.phonenumber;
    data['cnic'] = this.cnic;
    data['deliveryAddress'] = this.deliveryAddress;
    data['paymentmethod'] = this.paymentmethod;
    data['id']=this.id;
    return data;
  }
  Map<String, dynamic> tooJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.id;
    data['status'] = this.Status;
    return data;
  }
}
