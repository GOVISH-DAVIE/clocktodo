import 'dart:async';

import 'package:analog_clock/components/clock_view.dart';
import 'package:analog_clock/ui/colors.dart';
import 'package:analog_clock/utils/time.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:timer_builder/timer_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  Timer _everySec;

  Future<DateTime> fetchClock() async {
    now = DateTime.now();
    return now;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _everySec = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    /* getting time */

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 14, 14, 14),
      body: clock(),
      bottomNavigationBar: SalomonBottomBar(
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (i) {
          print(i);
          setState(() {
            _currentIndex = i;
          });
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.list),
            title: Text("Todo"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.lock_clock),
            title: const Text("Clock"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text("Donate"),
            selectedColor: Colors.orange,
          ),

          /// Profile
        ],
      ),
    );
  }

  SafeArea clock() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimerBuilder.periodic(
              Duration(seconds: 1),
              builder: (context) {
                //getting the time
                String second = DateTime.now().second < 10
                    ? "0${DateTime.now().second}"
                    : DateTime.now().second.toString();
                String minute = DateTime.now().minute < 10
                    ? "0${DateTime.now().minute}"
                    : DateTime.now().minute.toString();
                String hour = DateTime.now().hour < 10
                    ? "0${DateTime.now().hour}"
                    : DateTime.now().hour.toString();
                String day = DateTime.now().toString();
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today",
                          style: AppStyle.mainTextThin,
                        ),
                        Text(
                          "${hour}:${minute}",
                          style: AppStyle.maintext,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    ClockView(DataTime(DateTime.now().hour,
                        DateTime.now().minute, DateTime.now().second)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
