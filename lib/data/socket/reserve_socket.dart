import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:oneparking_citizen/data/models/reserve.dart';
import 'package:rxdart/rxdart.dart';

class ReserveSocket {
  String _url;
  SocketIOManager _manager;
  PublishSubject<ReserveNovelty> _noveltySubject;
  SocketIO _socket;
  String _plate;

  ReserveSocket(this._url) {
    _manager = SocketIOManager();

  }

  Future init() async{
    _socket = await _manager.createInstance(_url);
    _noveltySubject = PublishSubject();
  }

  PublishSubject<ReserveNovelty> novelty(String plate){
    _plate = plate;
    _socket.onConnect((c) {
      _socket.emit('subscribe', [
        {'plate': plate}
      ]);
    });
    _socket.on('state', (data) {
      final obj = data as Map<String, dynamic>;
      _noveltySubject.add(ReserveNovelty.fromJson(obj));
    });

    _socket.connect();

    return _noveltySubject;
  }

  void close(){
      _noveltySubject?.close();
      _socket?.emit('unsubscribe', [
        {'plate': _plate}
      ]);
      if(_socket != null){
        _manager.clearInstance(_socket);
      }

  }
}
