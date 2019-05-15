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
      appBar: AppBar(
        title: Text("Zonas",
          style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: onMapCreated,
            options: GoogleMapOptions(
              cameraPosition: CameraPosition(
                  target: LatLng(6.151379, -75.615247),
                zoom: 17.0
              )
            ),
          )
        ],
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.addMarker(
        MarkerOptions(
          position: LatLng(6.151374, -75.614445),
          infoWindowText: InfoWindowText("TItulo", "Zona Parqueadero")
        ),
    );
  }
}
