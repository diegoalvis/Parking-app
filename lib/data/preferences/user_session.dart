import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oneparking_citizen/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession{

  SharedPreferences _preferences;
  Future<SharedPreferences> get preferences async{
    if(_preferences != null) return _preferences;
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  Future<bool> get logged async{
     final prefs = await preferences;
     return prefs.getBool("logged") ?? false;
  }

  void setLogged(bool value) async{
    final prefs = await preferences;
    await prefs.setBool("logged", value);
  }


  Future<String> get token async{
    final prefs = await preferences;
    String tk = prefs.getString("token");
    return "Bearer $tk";
  }

  void setToken(String value) async{
    final prefs = await preferences;
    await prefs.setString("token", value);
  }


  Future<String> get name async{
    final prefs = await preferences;
    return prefs.getString("name");
  }

  void setName(String value) async{
    final prefs = await preferences;
    await prefs.setString("name", value);
  }


  Future<String> get id async{
    final prefs = await preferences;
    return prefs.getString("id");
  }

  void setId(String value) async{
    final prefs = await preferences;
    await prefs.setString("id", value);
  }

  Future<String> get phone async{
    final prefs = await preferences;
    return prefs.getString("phone");
  }

  void setPhone(String value) async{
    final prefs = await preferences;
    await prefs.setString("phone", value);
  }


  Future<bool> get disability async{
    final prefs = await preferences;
    return prefs.getBool("disability") ?? false;
  }

  void setDisability(bool value) async{
    final prefs = await preferences;
    await prefs.setBool("disability", value);
  }


  Future<bool> get firstTimeAccessible async{
    final prefs = await preferences;
    return prefs.getBool("first-accessible") ?? false;
  }

  void setFirstTimeAccessible(bool value) async{
    final prefs = await preferences;
    await prefs.setBool("first-accessible", value);
  }

  Future <bool> get isReserving async{
    final prefs = await preferences;
    return prefs.getBool("reserving") ?? false;
  }

  void setReserving(bool value) async{
    final prefs = await preferences;
    await prefs.setBool("reserving", value);
  }

  Future <int> get version async{
    final prefs = await preferences;
    return prefs.getInt("version") ?? -1;
  }

  void setVersion(int value) async{
    final prefs = await preferences;
    await prefs.setInt("version", value);
  }

  Future<bool> get holyDay async{
    final prefs = await preferences;
    return prefs.getBool("holyDay") ?? false;
  }

  void setHolyDay(bool value) async{
    final prefs = await preferences;
    await prefs.setBool("holyDay", value);
  }

  Future<String> get toDay async{
    final prefs = await preferences;
    return prefs.getString("toDay") ?? "";
  }

  void setToDay(int day, int month) async{
    final prefs = await preferences;
    await prefs.setString("toDay", "${day}_$month");
  }


  Future<LatLng> get lastLoc async{
    final prefs = await preferences;
    final lastLat =  prefs.getDouble("lastLat") ?? 0.0;
    final lastLng =  prefs.getDouble("lastLng") ?? 0.0;

    return lastLat == 0.0 || lastLng == 0.0 ? null : LatLng(lastLat, lastLng);

  }

  void setLastLoc(LatLng pos) async{
    final prefs = await preferences;
    await prefs.setDouble("lastLat", pos?.latitude ?? 0.0);
    await prefs.setDouble("lastLng", pos?.longitude ?? 0.0);
  }

  void init(String token, User user){
    setToken(token);
    setId(user.id);
    setName(user.name);
    setDisability(user.disability);
    setPhone(user.phone);
    setLogged(true);
  }

  // Logout
  Future clear() async {
    final prefs = await preferences;
    prefs.clear();
  }

}