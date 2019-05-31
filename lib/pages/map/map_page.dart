import 'dart:async';

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/pages/map/map_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oneparking_citizen/util/dialog-util.dart';
import 'package:oneparking_citizen/util/state-util.dart';
import 'package:location/location.dart';

void main() => runApp(MapPage());

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DialogUtil _dialogUtil = InjectorWidget.of(context).get();
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.bindSingleton(MapBloc(InjectorWidget.of(context).get()));
      },
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MapContainer(_dialogUtil)),
    );
  }
}

class MapContainer extends StatefulWidget {
  DialogUtil _dialogUtil;

  MapContainer(this._dialogUtil);

  _MapContainerState createState() => _MapContainerState(_dialogUtil);
}

class _MapContainerState extends State<MapContainer> {
  MapBloc _bloc;
  GoogleMapController mapController;
  List<Zone> zones;
  bool flagZones = false;
  bool trackingEnabled = false;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  DialogUtil _dialogUtil;

  _MapContainerState(this._dialogUtil);

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(6.151849, -75.616466),
    zoom: 17.0,
  );

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Injector injector = InjectorWidget.of(context);
    _bloc = injector.get<MapBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Zonas", style: TextStyle(color: Colors.black)),
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
            _addMarker();
          }
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              setState(() => this.mapController = controller);
            },
            markers: Set<Marker>.of(markers.values),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: !trackingEnabled ? Colors.white : Theme.of(context).accentColor,
          child: Icon(
            Icons.location_on,
            color: trackingEnabled ? Colors.white : Theme.of(context).accentColor,
          ),
          onPressed: trackGeolocation),
    );
  }

  void _addMarker() {
    if (this.flagZones == true) {
      for (var i = 0; i < this.zones.length; i++) {
        final MarkerId markerId = MarkerId(zones[i].idZone);
        final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(zones[i].lat, zones[i].lon),
          onTap: () {
            _onTapMarker(zones[i]);
          },
        );
        // adding a new marker to map
        markers[markerId] = marker;
      }
    }
  }

  _onTapMarker(Zone zoneTapped) {
    _dialogUtil.open.add(zoneTapped);
  }

  final location = new Location();

  trackGeolocation() async {
    setState(() => trackingEnabled = !trackingEnabled);
    final hasPermission = await location.hasPermission();
    if (hasPermission) {
      if (trackingEnabled) {
        final currentLocation = await location.getLocation();
        mapController
            .animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLocation.latitude, currentLocation.longitude), 17.0));
      }
      location.onLocationChanged().listen((LocationData currentLocation) {
        if (trackingEnabled) {
          mapController
              .animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLocation.latitude, currentLocation.longitude), 17.0));
        }
      });
    } else {
      location.requestPermission();
    }
  }
}
