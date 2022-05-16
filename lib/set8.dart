// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:mapbox_search/mapbox_search.dart';

class Ex17HomePage extends StatefulWidget {
  const Ex17HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex17HomePage> createState() => _Ex17HomePageState();
}

class _Ex17HomePageState extends State<Ex17HomePage> {

  void pickLocationFromMaps1(BuildContext context) async{
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => MapLocationPage(isContrib: true,radius: 100)));
    print(result);
    location1 = result[0].toString().replaceAll('[', '').replaceAll(']', '');
    proDeliveryAddress1.text = result[1].toString() + ", " + result[2].toString();
    setState(() {
      deliveryAddress1 = DateTime.now().millisecondsSinceEpoch.toString();
      location1 = result[0].toString().replaceAll('[', '').replaceAll(']', '');
      isLocation1 = true;
      latLon1.add(double.parse(result[1]));
      latLon1.add(double.parse(result[2]));
    });
  }

  void pickLocationFromMaps2(BuildContext context) async{
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => MapLocationPage(isContrib: true,radius: 100)));
    print(result);
    location2 = result[0].toString().replaceAll('[', '').replaceAll(']', '');
    proDeliveryAddress2.text = result[1].toString() + ", " + result[2].toString();
    setState(() {
      deliveryAddress2 = DateTime.now().millisecondsSinceEpoch.toString();
      location2 = result[0].toString().replaceAll('[', '').replaceAll(']', '');
      isLocation2 = true;
      latLon2.add(double.parse(result[1]));
      latLon2.add(double.parse(result[2]));
    });
  }

  TextEditingController proDeliveryAddress1 = TextEditingController();
  String deliveryAddress1 = '';
  TextEditingController proDeliveryAddress2 = TextEditingController();
  String deliveryAddress2 = '';

  TextEditingController locationController1 = TextEditingController();
  String location1 = '';
  bool isLocation1 = false;
  List<double> latLon1 = [];

  TextEditingController locationController2 = TextEditingController();
  String location2 = '';
  bool isLocation2 = false;
  List<double> latLon2 = [];

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  String totalDistance = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercise 18",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: ()  => pickLocationFromMaps1(context),
            child: Center(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 17
                  ),
                  controller: proDeliveryAddress1,
                  onChanged: (value){
                    print(value);
                    setState(() {
                      deliveryAddress1 = value;
                    });
                  },
                  enabled: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.tag),
                    border: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                    hintText: 'Location 1',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: ()  => pickLocationFromMaps2(context),
            child: Center(
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 17
                  ),
                  controller: proDeliveryAddress2,
                  onChanged: (value){
                    print(value);
                    setState(() {
                      deliveryAddress2 = value;
                    });
                  },
                  enabled: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.tag),
                    border: OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(),
                    hintText: 'Location 2',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
            GestureDetector(
              onTap: () async{
                // print('object');
                var x = calculateDistance(latLon1[0], latLon1[1], latLon2[0], latLon2[1]);
                setState(() {
                  totalDistance = x.toStringAsFixed(2);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(1,2.5)
                    )
                  ],
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            SizedBox(height: 100,),
            Center(
              child: Text(
                'Distance:\t\t' + totalDistance + ' KM',
              ),
            )
        ],
      ),
    );
  }
}

class MapLocationPage extends StatefulWidget {
  final bool isContrib;
  final double radius;
  const MapLocationPage({Key? key, required this.isContrib, required this.radius}) : super(key: key);

  @override
  _MapLocationPageState createState() => _MapLocationPageState();
}

class _MapLocationPageState extends State<MapLocationPage> {
  var locationMsg = '';
  var latitude, fixedLat;
  var longitude, fixedLon;
  bool _accept = true;
  bool isContrib = false;
  double zoom = 15.0;
  bool completed = false;

  void initState(){
    super.initState();
    setState(() {
      isContrib = widget.isContrib;
    });
    Future.delayed(Duration.zero, () async {
      WidgetsBinding.instance!.addPostFrameCallback((_) async{

  // Add Your Code here.
      await this.getCurrentLocation();

});
    });
  }

  Future<void> updatePosition(latLng.LatLng m) async{
    setState(() {
      latitude = m.latitude;
      longitude = m.longitude;
    });
  }

  Future<void> updateSearchPosition(List<double> center) async{
    setState(() {
      latitude = center[1];
      longitude = center[0];
    });
  }

  Future<void> reverseGeocode(List<double> latlon) async{
    var lat = latlon[0].toString();
    var lon = latlon[1].toString();
    // var zoomLvl = latlon[2].toInt();
    // Uri url = Uri.https('nominatim.openstreetmap.org', '/reverse' ,{'format': 'json', 'lat': lat.toString(), 'lon': lon.toString(), 'zoom': zoomLvl.toString(), 'addressdetails':'1'} );
    Uri url = Uri.parse('https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&zoom=30&addressdetails=1');
    var response = await get(url);
    if(response.statusCode == 200){
      var ans = jsonDecode(response.body);
      if(widget.isContrib == false){
        Navigator.pop(context, ans['display_name']);
      }
      else{
        Navigator.pop(context, [ans['display_name'], lat, lon]);
      }
    }
  } 

  Future<void> getCurrentLocation() async{
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    setState(() {
      latitude = position.latitude;
      fixedLat = latitude;
      longitude = position.longitude;
      fixedLon = longitude;
      locationMsg = "$position.latitude, $position.longitude";
      this.completed = true;
    });
  }

  var placesSearch = PlacesSearch(
      apiKey: 'pk.eyJ1IjoibXItYW5vbnltb3VzLW9mZmljaWFsIiwiYSI6ImNraHhnZ2s4djBqY3gyeG1wb21zcTRzY3kifQ.4t9DRO4DF7s4gaGy7HS6hg',
      limit: 5,
  );

  Future<void> searchComplete(String place) async{
    List<MapBoxPlace>? places = await placesSearch.getPlaces(place);
    final location = await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultPage(places, place.toString())));
    print(places);
    updateSearchPosition(location);
    print(location);
  }

  Future<void> updatePointerPosition(MapPosition center) async{
    WidgetsBinding.instance!.addPostFrameCallback((_){
        setState(() {
          latitude = center.center?.latitude;
          longitude = center.center?.longitude;
        });
    });
  }

  late MapPlugin mapPlugin;
  MapController mapController = MapController();

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  // final _startPointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_rounded, color: Colors.black, size: 28,)),
        title: Text(
          'Select Location',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black
          ),
        ),
        actions: [
          // SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.9,
          //   child: TextFormField(
          //     style: TextStyle(
          //       fontSize: 18
          //     ),
          //     decoration: InputDecoration(
          //       border: InputBorder.none,
          //       icon: Icon(FontAwesomeIcons.mapMarkerAlt, size: 25,),
          //       hintText: 'Select Pet Location',
          //     ),
          //     onChanged: (value){
          //       print(value);
          //     },
          //     onFieldSubmitted: (value){
          //       searchComplete(value);
          //     },
          //   ),
          // ) 
        ],
      ),
      floatingActionButton: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: GestureDetector(
          onTap: () => getCurrentLocation(),
          child: Center(
            child: FaIcon(
              Icons.gps_fixed_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
      body: completed ? Stack(
        children: [FlutterMap(
          options: MapOptions(
            controller: mapController,
            center: latLng.LatLng(latitude, longitude),
            zoom: widget.isContrib ? 18 : 15.0,
            // enableScrollWheel: true,
            enableMultiFingerGestureRace: widget.isContrib ? false : true,
            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            onTap: (p,m) => print(m.latitude.toString()),
            onPositionChanged: widget.isContrib == false ? (m, q) => updatePointerPosition(m) : (m, q){
              updatePointerPosition(m);
              if(calculateDistance(latitude, longitude, fixedLat, fixedLon) > widget.radius *0.001){
                _accept = false;
              }
              else{
                _accept = true;
              }
            },
            onLongPress: (p,m)=> updatePosition(m),
            slideOnBoundaries: true,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a','b','c'],
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80,
                  height: 80,
                  point: new latLng.LatLng(latitude, longitude),
                  builder: (context) => Center(
                    child: Container(
                      child: FaIcon(
                        FontAwesomeIcons.mapPin,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                  )
                ),
              ],
            ),
            CircleLayerOptions(
              circles: [
                CircleMarker(
                  point: new latLng.LatLng(fixedLat, fixedLon),
                  color: Colors.blue.withOpacity(0.3),
                  borderStrokeWidth: 3.0,
                  useRadiusInMeter: true,
                  borderColor: Colors.blue,
                  radius: widget.radius
                )
              ]
            )
          ],
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.001,
          right: MediaQuery.of(context).size.width * 0.001,
          top: MediaQuery.of(context).size.height * 0.75,
          bottom: MediaQuery.of(context).size.height * 0.001,
          child: GestureDetector(
            onTap: () async=> await reverseGeocode([latitude, longitude, zoom]) ,
            // : _accept == true ? () async=> await reverseGeocode([latitude, longitude, zoom]) : null,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.25,
              // alignment: Alignment.center,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Color(0xFF0F48B8),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'Confirm Location',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                            ),
                          ),
                          SizedBox(width: 15,),
                          Icon(Icons.check_circle, color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
        )
        ]
      ) : Center(child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      )),
    );
  }
}

class SearchResultPage extends StatefulWidget {
  final List<MapBoxPlace>? places;
  final String query;
  const SearchResultPage(this.places, this.query);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: GestureDetector(onTap: ()=> Navigator.of(context).pop(null), child: Icon(Icons.arrow_back_rounded, size: 22, color: Colors.black,)),
        title: Text(
          'Search Results for ${widget.query}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.places!.length,
        itemBuilder: (_, int index){
          final placeName = widget.places![index].placeName;
          return Card(
            child: GestureDetector(
              onTap: ()=> Navigator.pop(context, widget.places![index].center),
              child: ListTile(
                title: Text(placeName.toString()),
                trailing: Icon(Icons.launch),
              ),
            ));
        }
      ),
    );
  }
}

class Ex18HomePage extends StatefulWidget {
  const Ex18HomePage({ Key? key }) : super(key: key);

  @override
  State<Ex18HomePage> createState() => _Ex18HomePageState();
}

class _Ex18HomePageState extends State<Ex18HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercise 18",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}