import 'package:flutter/material.dart';
import 'package:muetattendance/services/attendanceService.dart';
import 'package:provider/provider.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  
  var selectedDept=null;
  var selectedSession=null;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<AttendanceService>(
          builder: (context, prv, _) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    hint: Text('Select Department'),
                    isExpanded: true,
                      value: selectedDept,
                      items: prv.departments?.entries
                          .map((e) => DropdownMenuItem(value: e.value,child: Text(e.key),))
                          .toList(),
                      onChanged: (value)=>setState((){
                        selectedSession=null;
                        selectedDept=value;
                        prv.getSessions('$value');
                      })
                  ),
                  DropdownButton(
                    hint: const Text('Select Class/Section'),
                    isExpanded: true,
                      value: selectedSession,
                      items: prv.sessions?.entries
                          .map((e) => DropdownMenuItem(value: e.value,child: Text(e.key),))
                          .toList(),
                      onChanged: (value)=>setState((){
                        selectedSession=value;
                        
                      })
                  ),
                ],
              ),
            );
          }
        ),
      );
  }
  
}
