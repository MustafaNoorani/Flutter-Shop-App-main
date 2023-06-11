import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shop_app/models/location.dart';
class workshop{
  Future<List<Location>>? location ;
  add_marker(double  lat,double long,String title ) async {
    try {
      Location data = new Location(markerid:"",lat: lat, long: long, title: title);

      http.Response response =
      await http.post(
          Uri.parse("https://adorable-blue-frock.cyclic.app/api/user/location/addmarker"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data.toJson()));
      print(response.body);

    }
    catch (e) {
      print(e.toString());
    }
  }
  Future<List<Location>> getAllLocation() async {
    String url = 'https://adorable-blue-frock.cyclic.app/api/user/location/getmarker';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
       location=getdata(json);
       //return location;
    }
    return [];
     }
  // getLocation() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.requestPermission();
  //
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   double lat = position.latitude;
  //   double long = position.longitude;
  //
  //
  //   LatLng location = LatLng(lat, long);
  //   String url = 'https://adorable-blue-frock.cyclic.app/api/user/location/getmarker';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     var json = jsonDecode(response.body) as List;
  //     setState(() {
  //       jsonList = json;
  //     });
  //   }
  //   setState(() {
  //     _currentPosition = location;
  //     _isLoading = false;
  //     latuser = position.latitude;
  //     longuser = position.longitude;
  //   });
  //   jsonList!.forEach((element) {
  //     markers.putIfAbsent(
  //         element["markerid"]
  //         ,
  //             () =>
  //             Marker(
  //                 markerId: MarkerId(element['markerid']),
  //                 position: LatLng(element['lat'], element['long']),
  //                 infoWindow: InfoWindow(
  //                     title: element['title']
  //                 )));
  //   });
  //   //print(list);
  // }
  Future<List<Location>> getdata(List<dynamic> myData) async {
    final todos = myData.map((e) {
      return Location(markerid: e["markerid"],lat: e["lat"], long: e["long"], title: e["title"]);

    }).toList();

    return todos;

  }
}