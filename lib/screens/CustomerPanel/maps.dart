import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  late GoogleMapController mapController;

  LatLng? _currentPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  double? latuser ;
  double? longuser ;


  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;


    LatLng location = LatLng(lat, long);

    // setState(() {
    //
    // });
    print(latuser);
    print(longuser);
    List<dynamic> jsonList =[];
      String url = 'https://adorable-blue-frock.cyclic.app/api/user/location/getmarker';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body) as List;
        setState(() {
          jsonList = json;
        });
      }
      //print(markers);
      setState(() {
        _currentPosition = location;
        _isLoading = false;
        latuser = position.latitude;
        longuser = position.longitude;
        jsonList!.forEach((element) {
          markers.putIfAbsent(
              MarkerId(element["markerid"])
              ,
                  () =>
                  Marker(
                      markerId: MarkerId(element['markerid']),
                      position: LatLng(element['lat'], element['long']),
                      infoWindow: InfoWindow(
                          title: element['title']
                      )));
        });
      });
  print(markers);
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(latuser!, longuser!),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );

    setState(() {
      markers[MarkerId('place_name')] = marker;

    });
    print(markers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 16.0,
        ),
        markers: markers.values.toSet(),
      ),
    );
  }
}
