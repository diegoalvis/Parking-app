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