import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/pages/map/map_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oneparking_citizen/util/state-util.dart';

void main() => runApp(MapPage());

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.bindSingleton(MapBloc(InjectorWidget.of(context).get()));
      },
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MapContainer()),
    );
  }
}

class MapContainer extends StatefulWidget {
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer>{

  MapBloc _bloc;
  GoogleMapController mapController;
  List<Zone> zones = [];
  bool flagZones = false;

  @override
  Widget build(BuildContext context) {
    _bloc = InjectorWidget.of(context).get<MapBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Zonas",
          style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is InitialState) {
            _bloc.dispatch(MapEvent.fetchData);
          }
          if (state is SuccessState<List<Zone>>) {
            zones = state.data;
            this.flagZones = true;
          }
          return Stack(
            children: <Widget>[
              GoogleMap(
                options: GoogleMapOptions(
                    cameraPosition: CameraPosition(
                        target: LatLng(6.151379, -75.615247),
                        zoom: 17.0
                    )
                ),
                onMapCreated: _onMapCreated,
              )
            ],
          );
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {

    Future.delayed(const Duration(milliseconds: 5000), () {
      setState(() {
        mapController = controller;
        if(this.flagZones == true) {
          for(var i = 0 ; i < this.zones.length ; i++) {
            mapController.addMarker(
              MarkerOptions(
                  position: LatLng(zones[i].lat, - zones[i].lon)
              ),
            );
          }
        }
      });
    });


  }


}
