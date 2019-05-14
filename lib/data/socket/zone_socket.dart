import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:oneparking_citizen/data/models/zone.dart';
import 'package:rxdart/rxdart.dart';

class ZoneSocket {

  String _url;
  SocketIOManager _manager;
  PublishSubject<ZoneNovelty> _noveltySubject;


  ZoneSocket(this._url) {
    _manager = SocketIOManager();
    _noveltySubject = PublishSubject();
  }

  Future<PublishSubject<ZoneNovelty>> count(String idZone) async {
    SocketIO _socket = await _manager.createInstance(_url);
    _socket.emit('subscribe', [{'zone': idZone}]);

    _socket.on('reserves', (data) {
      final obj = data[0] as Map<String, dynamic>;
      _noveltySubject.add(ZoneNovelty.fromJson(obj));
    });

    return _noveltySubject.doOnCancel(() {
      _socket.emit('unsubscribe', [{'zone': idZone}]);
      _manager.clearInstance(_socket);
    });
  }


}

