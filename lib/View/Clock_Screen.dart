import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer/Provider/dateTime_Provider.dart';
import 'package:timer/Widgets/clock_View.dart';
import 'package:timer/Widgets/custom_LabelText.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    print('What are you building now');
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        //color: Color(0xff2D2F41),
        color: const Color.fromARGB(255, 45, 65, 87),
        child: Padding(
          padding: EdgeInsets.only(left: w * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.02,
              ),
              CustomLabelText(
                fontsize: h * 0.04,
                customLabelText: 'Clock',
              ),
              Padding(
                padding: EdgeInsets.only(left: w * 0.06, top: h * 0.03),
                child: const ClockView(),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Consumer<TimeProvider>(
                builder: (context, timeProvider, _) {
                  final currentTime = timeProvider.currentTime;
                  final formattedTime =
                      DateFormat('hh : mm : ss a').format(currentTime);
                  return Text(
                    formattedTime,
                    style: GoogleFonts.oswald(
                        letterSpacing: 2,
                        color: Colors.white,
                        fontSize: h * 0.05),
                  );
                },
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Consumer<TimeProvider>(
                builder: (context, timeProvider, _) {
                  final currentDate = timeProvider.currentTime;
                  var timezoneString =
                      currentDate.timeZoneOffset.toString().split(".").first;
                  var offsetSign = '';
                  if (!timezoneString.startsWith('-')) offsetSign = "+";
                  print(timezoneString);
                  final formattedDate =
                      DateFormat('EEE, d MMM').format(currentDate);
                  return Text(
                    formattedDate,
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: h * 0.03),
                  );
                },
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Text(
                'Time Zone',
                style: GoogleFonts.prompt(
                    color: Colors.white, fontSize: h * 0.035),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/world.png',
                    height: h * 0.035,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: w * 0.02,
                  ),
                  Consumer<TimeProvider>(
                    builder: (context, timeProvider, _) {
                      final currentDate = timeProvider.currentTime;
                      var timezoneString = currentDate.timeZoneOffset
                          .toString()
                          .split(".")
                          .first;
                      var offsetSign = '';
                      if (!timezoneString.startsWith('-')) offsetSign = "+";
                      print(timezoneString);

                      return Text(
                        'UTC' + offsetSign + timezoneString,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: h * 0.03),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
