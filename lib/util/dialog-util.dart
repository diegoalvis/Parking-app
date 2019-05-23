import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:rxdart/rxdart.dart';

class DialogUtil {
  PublishSubject<Zone> open;

  DialogUtil(){
    open = PublishSubject();
  }

  void dispose(){
    open.close();
  }
}
