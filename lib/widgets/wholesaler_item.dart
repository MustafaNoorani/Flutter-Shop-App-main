

import 'package:flutter/material.dart';
import 'package:shop_app/provider/user_provider.dart';


// ignore: must_be_immutable
class WholesalerListItem extends StatefulWidget {
   userModel wholesaler;
  WholesalerListItem({Key? key, required this.wholesaler}) : super(key: key);

  @override
  State<WholesalerListItem> createState() => _WholesalerListItemState();
}
String _Mode = "undelivered";
class _WholesalerListItemState extends State<WholesalerListItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
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
                          "user Id: ${widget.wholesaler.userid.toString()}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 3),
                    child: Text(
                      // DateFormat.yMEd().add_jms().format(widget.order.dateTime),
                      "Email: ${widget.wholesaler.email.toString()}",
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

                  children: [
                    if (_isExpanded)
                      Text(
                        'User Details',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    if (_isExpanded)
                      Text(
                        widget.wholesaler.fullname.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w100),
                      ),
                    if (_isExpanded)
                      Text(
                        widget.wholesaler.phone.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w100),
                      ),
                    if (_isExpanded)
                      Text(
                        widget.wholesaler.password.toString(),
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
                        "Block",
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


            ]
        ),
      ),
    );
  }
}

