

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/provider/order_provider.dart';

import '../models/cart.dart';
import '../models/order.dart';
import '../provider/product_provider.dart';
import '../screens/login_registration/wholesaler_registration.dart';

// ignore: must_be_immutable
class OrderItem extends StatefulWidget {
  Order order;
  OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}
String _Mode = "undelivered";
class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    var orders = Provider.of<OrderProvider>(context);
    var product = Provider.of<ProductProvider>(context);
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8.0),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 15),
                    child: Row(
                      children: [
                        Text(
                          "${widget.order.userid.toString()}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only (left: MediaQuery.of(context).size.width / 5),
                          child: Text(

                            "RS ${widget.order.totalAmount.toStringAsFixed(2)}",

                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 3),
                    child: Text(
                      // DateFormat.yMEd().add_jms().format(widget.order.dateTime),
                      widget.order.dateTime,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  trailing: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.indigo,
                      size: 28),
                ),
              ),
              if (_isExpanded)
                Padding(
                  padding: const EdgeInsets.only(left: 22.0, top: 5, bottom: 5),
                  child: Column(

                    children: widget.order.orderItems.map((singleProduct) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            singleProduct.productName,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                            child: SizedBox(
                              width: 85,
                              child: Text(
                                "${singleProduct.quantity} x ${singleProduct.price}",
                                style: const TextStyle(
                                  fontSize: 14.5,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),

                  ),


                ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0, top: 5, bottom: 5),
                child: Column(

                  children: [
                    if (_isExpanded)
                      Text(
                        'Shipping Details',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    if (_isExpanded)
                      Text(
                        widget.order.deliveryAddress.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w100),
                      ),
                    if (_isExpanded)
                      Text(
                        widget.order.phonenumber.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w100),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                  child: Card(
                    color: Colors.black,
                    margin: const EdgeInsets.all(0),
                    child: SizedBox(
                      width: _screenSize.width * 0.4,
                      height: 40,
                      child:  Center(
                        child: Text(
                          widget.order.Status.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 250),
                child: InkWell(
                  onTap: (){
                    //
                    widget.order.orderItems.map((e) {
                      int i =0;
                      orders.quantity.putIfAbsent(e.id, () {
                        return Cart(id: e.id, pid: "", itemid: "", productName: "", imgUrl: "", price: 0, quantity: e.quantity+product.quantitylist[i]);
                      });
                      i++;
                    }).toList();
                    orders.quantity.forEach((String, Cart) {
                      product.update_product_quantity(Cart.id, Cart.quantity);
                    });
                    //
                    orders.clearApiOrder(widget.order.id);

                  },
                  child: Card(
                    color: Colors.black,
                    //margin: const EdgeInsets.all(0),
                    child: SizedBox(
                      width: _screenSize.width * 0.4,
                      height: 40,
                      child:  Center(
                        child: Text(
                          " Cancel ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),


            ]
        ),
      ),
    );
  }
}

