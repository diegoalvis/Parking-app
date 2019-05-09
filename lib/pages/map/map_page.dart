import 'package:flutter/material.dart';
import '../main/main_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MapPage());

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapContainer()
    );
  }
}

class MapContainer extends StatefulWidget {
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer>{
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
              onMapCreated: onMapCreated,
            options: GoogleMapOptions(
              cameraPosition: CameraPosition(
                  target: LatLng(6.151379, -75.615247),
                zoom: 15.0
              )
            ),
          )
        ],
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
