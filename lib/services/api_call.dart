import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';

class AttendanceService extends ChangeNotifier {
  late Socket _socket;
  bool loading = true;
  Map? attendanceData;

  AttendanceService() {
    _socket = io('http://13.233.79.106:3000',
        OptionBuilder().setTransports(['websocket']).build());
    _socket.onConnect((data) {
      print('ehe');
      
      _socket.on('response', (data) {
        //attendanceData=data;
        print(data);
        loading = false;
        notifyListeners();
      });
      
      _socket.on('sessions', (data) {
        print(data);
        loading = false;
        notifyListeners();
      });
    });
  }

  getAttendance() {
    loading = true;
    notifyListeners();
    _socket.emit('getAttendance', '1,33,12,Both,0');
  }
}
