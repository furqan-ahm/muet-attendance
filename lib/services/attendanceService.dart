import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';

class AttendanceService extends ChangeNotifier {
  late Socket _socket;
  bool loading = true;

  bool get isConnected=>_socket.connected;

  Map? attendanceData;
  Map? sessions;
  Map? departments;

  AttendanceService() {
    _socket = io('http://13.233.79.106:3000',
        OptionBuilder().setTransports(['websocket']).build());


    _socket.onDisconnect((data) => notifyListeners());
    
    
    _socket.onConnect((data) {
      notifyListeners();
      //print('ehe');
      print('connected');
      notifyListeners();
      _socket.on('response', (data) {
        attendanceData=data;
        //print(data);
        loading = false;
        notifyListeners();
      });
      
      _socket.on('sessions', (data) {
        sessions=data['sessions'];
        loading = false;
        notifyListeners();
      });
      
      _socket.on('departments', (data) {
        print(data);
        departments=data['departments'];
        loading = false;
        notifyListeners();
      });

    });
  }


  getDepartments(){
    loading=true;
    notifyListeners();
    _socket.emit('getDepartments');
  }
  
  getSessions(String deptID){
    loading=true;
    notifyListeners();
    _socket.emit('getSessions', deptID);
  }

  getAttendance(String sessionID) {
    loading = true;
    notifyListeners();
    _socket.emit('getAttendance', sessionID);
  }
}
