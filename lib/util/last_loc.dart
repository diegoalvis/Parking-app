import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oneparking_citizen/data/preferences/user_session.dart';

class LastLoc{

  LatLng _last;
  UserSession _session;
  LastLoc(this._session);

  setLast(LatLng last) async{
    _last = last;
  }

  save(){
    _session.setLastLoc(_last);
  }

  Future<LatLng> getLast() async{
    if(_last != null){
      return _last;
    }else{
      _last = await _session.lastLoc;
      return _last;
    }
  }


}