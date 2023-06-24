import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/View/Alarm_Screen.dart';
import 'package:timer/View/Clock_Screen.dart';
import 'package:timer/View/StopeWatch_Screen.dart';
import 'package:timer/Widgets/custom_TabText.dart';

class MyTabBarView extends StatefulWidget {
  const MyTabBarView({super.key});

  @override
  _MyTabBarViewState createState() => _MyTabBarViewState();
}

class _MyTabBarViewState extends State<MyTabBarView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedindex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 45, 65, 87),
        // backgroundColor: Color(0xff2D2F41),
        bottom: TabBar(
          padding: EdgeInsets.symmetric(horizontal: h * 0.02),
          indicator: BoxDecoration(
              color: Colors.orange[300],
              borderRadius: BorderRadius.circular(30)),
          controller: _tabController,
          tabs: [
            TabText(
              text: 'Clock',
              color: selectedindex == 0 ? Colors.black : Colors.white,
            ),
            TabText(
              text: 'Alarm',
              color: selectedindex == 1 ? Colors.black : Colors.white,
            ),
            TabText(
              text: 'Stoper',
              color: selectedindex == 2 ? Colors.black : Colors.white,
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Contents of Tab 1
          ClockScreen(),

          // Contents of Tab 2
          AlarmScreen(),

          // Contents of Tab 3
          StopWatchScreen(),
        ],
      ),
    );
  }
}
