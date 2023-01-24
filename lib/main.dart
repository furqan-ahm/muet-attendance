import 'package:flutter/material.dart';
import 'package:muetattendance/services/api_call.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AttendanceService>(
      create: (context) => AttendanceService(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceService>(
      builder: (context, prv, _) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  '19SW08 Attendance',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: prv.attendanceData==null?0:(prv.attendanceData?['students']['19SW08'] as Map).length,
                    itemBuilder: (context, index) {
                      if(prv.attendanceData!=null){
                        return Text(prv.attendanceData?['students']['19SW08'].keys.elementAt(index)+' '+prv.attendanceData?['students']['19SW08'].values.elementAt(index)['percentage']);
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('Refresh'),
            onPressed: prv.getAttendance,
            tooltip: 'Increment',
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      }
    );
  }
}
