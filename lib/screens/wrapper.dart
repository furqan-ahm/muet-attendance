import 'package:flutter/material.dart';
import 'package:muetattendance/screens/loading_screen.dart';
import 'package:muetattendance/screens/select_screen.dart';
import 'package:muetattendance/services/attendanceService.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Provider.of<AttendanceService>(context).isConnected?const SelectScreen():const LoadingScreen();
  }
}