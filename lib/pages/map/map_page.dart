import 'dart:async';

import 'package:dependencies/dependencies.dart';
import 'package:dependencies_flutter/dependencies_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:oneparking_citizen/pages/map/map_bloc.dart';
import 'package:oneparking_citizen/util/dialog-util.dart';
import 'package:oneparking_citizen/util/last_loc.dart';
import 'package:oneparking_citizen/util/state-util.dart';

void main() => runApp(MapPage());

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DialogUtil _dialogUtil = InjectorWidget.of(context).get();
    final LastLoc _lastLoc = InjectorWidget.of(context).get();
    return InjectorWidget.bind(
      bindFunc: (binder) {
        binder.bindSingleton(MapBloc(InjectorWidget.of(context).get()));
      },
      child: MapContainer(_dialogUtil, _lastLoc),
    );
  }
}

class MapContainer extends StatefulWidget {
  DialogUtil _dialogUtil;
  final LastLoc _lastLoc;

  MapContainer(this._dialogUtil, this._lastLoc);

  _MapContainerState createState() => _MapContainerState(_dialogUtil, _lastLoc);
}

class _MapContainerState extends State<MapContainer> {
  MapBloc _bloc;
  GoogleMapController mapController;
  List<Zone> zones;
  bool flagZones = false;
  bool trackingEnabled = false;
  StreamSubscription _locationStream;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  DialogUtil _dialogUtil;
  LastLoc _lastLoc;

  _MapContainerState(this._dialogUtil, this._lastLoc);

  CameraPosition _initialPosition = CameraPosition(
    target: LatLng(6.151849, -75.616466),
    zoom: 17.0,
  );

  @override
  void dispose() {
    _lastLoc.save();
    _bloc.dispose();
    _locationStream?.cancel();
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
            myLocationEnabled: trackingEnabled,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              _startMap(controller);
            },
            onCameraMove: (pos) {
              _lastLoc.setLast(pos.target);
            },
            markers: Set<Marker>.of(markers.values),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor:
              !trackingEnabled ? Colors.white : Theme.of(context).accentColor,
          child: Icon(
            Icons.location_on,
            color:
                trackingEnabled ? Colors.white : Theme.of(context).accentColor,
          ),
          onPressed: trackGeolocation),
    );
  }

  _startMap(GoogleMapController controller) async {
    final initial = await _lastLoc.getLast();
    if (initial != null) {
      mapController.moveCamera(CameraUpdate.newLatLng(initial));
    }
  }

  void _addMarker() {
    if (this.flagZones == true) {
      for (var i = 0; i < this.zones.length; i++) {
        final MarkerId markerId = MarkerId(zones[i].idZone);
        final Marker marker = Marker(
          markerId: markerId,
          consumeTapEvents: true,
          icon: BitmapDescriptor.defaultMarkerWithHue(150),
          position: LatLng(zones[i].lat, zones[i].lon),
          onTap: () {
            _onTapMarker(zones[i]);
            mapController.animateCamera(
                CameraUpdate.newLatLng(LatLng(zones[i].lat, zones[i].lon)));
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
    final current = !trackingEnabled;
    if (!current) {
      setState(() => trackingEnabled = current);
      _locationStream?.cancel();
      _locationStream = null;
    } else {
      final hasPermission = await location.hasPermission();
      if (hasPermission) {
        _checkService();
      } else {
        final perm = await location.requestPermission();
        if (perm) {
          _checkService();
        }
      }
    }
  }

  _checkService() async {
    bool enabled = await location.serviceEnabled();
    if (enabled) {
      setState(() => trackingEnabled = true);
      _startTrackGeoLocation();
    } else {
      enabled = await location.requestService();
      if (_startTrackGeoLocation()) {
        setState(() => trackingEnabled = true);
        _startTrackGeoLocation();
      }
    }
  }

  _startTrackGeoLocation() async {
    final currentLocation = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(currentLocation.latitude, currentLocation.longitude), 17.0));

    _locationStream =
        location.onLocationChanged().listen((LocationData currentLocation) {
      mapController.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(currentLocation.latitude, currentLocation.longitude), 17.0));
    }, onError: (e) {
      print("");
    }, onDone: () {
      print("");
    });
  }
}
