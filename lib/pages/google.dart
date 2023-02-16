import 'dart:core';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsuygulama/models/api.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:translator/translator.dart';

String description = "";

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  ScrollController _scrollController = ScrollController();
  GoogleTranslator translator = GoogleTranslator();

  var currentPos;
  var currentLat = 38.392300;
  var currentLong = 27.047840;

  BitmapDescriptor? markerIcon;

  Set<Marker> _markers = {};

  List<double> _latitude = [];
  List<double> _longitude = [];

  Future<List<MarkerModel>> _getMarkerlist() async {
    try {
      var response = await Dio().get(
        'https://ancientcitiesturkey.com/api/tr/ruins',
      );

      List<MarkerModel> _markerList = [];

      if (response.statusCode == 200) {
        _markerList =
            (response.data as List).map((e) => MarkerModel.fromMap(e)).toList();

        //debugPrint(_markerList.toString());
        return _markerList;
      }
    } on DioError catch (e) {
      print('a');
      return Future.error(e.message);
    }
    return _getMarkerlist();
  }

  late Future<List<MarkerModel>> markerAlbum;

  Future<Map<String, dynamic>> _getRuins(String slug) async {
    try {
      var response2 = await Dio().get(
        'https://ancientcitiesturkey.com/api/tr/ruins/' + slug,
      );

      Map<String, dynamic> responseMap = {};

      if (response2.statusCode == 200) {
        responseMap = response2.data;

        return responseMap;
      }
    } on DioError catch (e) {
      //print('a');
      return Future.error(e.message);
    }
    return _getRuins(slug);
  }

  void addCustomIcon() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/star-6.png");
    print(markerIcon);
  }

  @override
  void initState() {
    addCustomIcon();

    markerAlbum = _getMarkerlist();
    super.initState();
  }

  Widget informationNull(String description) {
    return Text(
      description,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget hypeLink(text2, uriLink) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // ignore: deprecated_member_use
                launch(uriLink);
              },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
        centerTitle: false,
        title: const Text('Historical Place in Turkey'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(38.9573415, 35.240741),
              zoom: 5,
            ),
          ),
          FutureBuilder<List<MarkerModel?>>(
            future: markerAlbum,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                for (int j = 0; j < snapshot.data!.length; j++) {
                  _latitude.add(snapshot.data![j].latitude);
                  _longitude.add(snapshot.data![j].longitude);
                }

                for (int i = 0; i < snapshot.data!.length; i++) {
                  _markers.add(
                    Marker(
                      markerId: MarkerId(i.toString()),
                      position: LatLng(_latitude[i], _longitude[i]),
                      icon: markerIcon!,
                      onTap: () async {
                        var myData = await _getRuins(snapshot.data![i].slug);
                        var description = await myData['information'];
                        Future<String> translate(description) async {
                          var translater =
                              await translator.translate(description, to: "en");
                          return translater.text;
                        }

                        _customInfoWindowController.addInfoWindow!(
                          Container(
                            width: 600,
                            height: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 400,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            'https://ancientcitiesturkey.com/' +
                                                myData['image'],
                                          ),
                                          fit: BoxFit.fill,
                                          filterQuality: FilterQuality.high),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 120,
                                      child: Text(
                                        snapshot.data![i].name,
                                        maxLines: 5,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          wordSpacing: 5,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  informationNull(description),
                                  SizedBox(height: 20),
                                  Text('Türkçe Kaynak',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 13),
                                  hypeLink(
                                    myData["turkish_links"][0]["description"],
                                    myData["turkish_links"][0]["url"],
                                  ),
                                  SizedBox(height: 13),
                                  Text(
                                    'English Resources',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 13),
                                  hypeLink(
                                    myData['english_links'][1]["description"],
                                    myData['english_links'][1]["url"],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          LatLng(
                            _latitude[i],
                            _longitude[i],
                          ),
                        );
                      },
                    ),
                  );
                }
              }
              return CircularProgressIndicator();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 350,
            width: 350,
            offset: 35,
          ),
        ],
      ),
    );
  }
}
