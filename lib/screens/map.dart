import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Map extends StatelessWidget {
  final String title;
  Map(this.title);

  static const iconColor = Color.fromRGBO(123, 123, 130, 0.5);
  static const appTitleColor = Color.fromRGBO(69, 69, 77, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 20, color: iconColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(title,
              style: TextStyle(color: appTitleColor, fontSize: 24),
            ),
          ),
        ),
      ),
      body: Text("MAP"),
    );
  }
}

class MapContainer extends StatefulWidget {
  @override
  _MapContainer createState() => _MapContainer();
}

class _MapContainer extends State<MapContainer> {
  CameraPosition _initialPosition = CameraPosition(target: LatLng(54.976462, 73.33415400000001),zoom: 15,);
  Completer<GoogleMapController> _controller = Completer();
  MapType _defaultMapType = MapType.normal;
  final Set<Marker> _markers = Set();
  final double _zoom = 17;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }

  Widget map() {
    return Padding(
      padding: EdgeInsets.only(top: 55, left: 10, right: 10, bottom: 120),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(7.0),
        textStyle: TextStyle(fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
            color: Color.fromRGBO(31, 32, 65, 0.8)),
        child: Container(
          color: Color.fromRGBO(224, 224, 224, 1),
          child: Stack(
            children: <Widget>[
              GoogleMap(
                markers: _markers,
                mapType: _defaultMapType,
                myLocationEnabled: true,
                initialCameraPosition: _initialPosition,
                onMapCreated: _onMapCreated,
              ),
              Container(
                margin: EdgeInsets.only(top: 80, right: 10),
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                  SizedBox(
                    child: FloatingActionButton(
                      child: Icon(Icons.layers),
                      elevation: 5,
                      backgroundColor: Color.fromARGB(200, 0, 26, 128),
                      onPressed: () {
                        _changeMapType();
                      }),
                ),
                    SizedBox(
                      child: FloatingActionButton(
                          child: Icon(Icons.card_travel),
                          elevation: 5,
                          backgroundColor: Color.fromARGB(200, 0, 26, 128),
                          onPressed: () {
                            _goToForum();
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),  //EdgeInsets.only(left: 15,right: 15, top: 25,bottom: 100),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(7.0),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Color.fromRGBO(31, 32, 65, 0.8)),
        child: Container(
            color: Color.fromRGBO(224, 224, 224, 1),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Center(
                      child: Text('Конгресс-холл',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Color.fromRGBO(31, 32, 65, 0.8),
                        ),
                      ),
                    ),
                    Center(
                      child: Text('г.Омск,ул.70лет Октября, 25/2',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, height: 1.5, fontFamily: 'Montserrat',color: Color.fromRGBO(31, 32, 65, 0.8)
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment(0.0, 0.7),
                  child: Text("Для участников ИТ-форума гостиница\n со скидкой - Аврора,\"Отель 41\"",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, height: 1.5, fontFamily: 'Montserrat',color: Color.fromRGBO(31, 32, 65, 0.8)
                    ),
                  ),
                ),
                map(),
              ],
            )
        ),
      ),
    );
  }

  Future<void> _goToForum() async {
    double lat = 54.976462;
    double long = 73.33415400000001;
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('holl'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'Конгресс-холл',  snippet: 'Добро пожаловать на Омский IT-форум 2019')
        ),
      );
    });
  }
}