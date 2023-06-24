import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer/Model/alarm_info.dart';
import 'package:timer/Services/alarm_helper.dart';
import 'package:timer/Services/notification_Service.dart';
import 'package:timer/Widgets/custom_LabelText.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  DateTime? _alarmTime;
  late String _alarmTimeString;
  bool _isRepeatSelected = false;
  final AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
    NotificationServices().initialiseNotifications();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 65, 87),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.09),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h * 0.02,
            ),
            CustomLabelText(
              customLabelText: 'Alarm',
              fontsize: h * 0.035,
            ),
            SizedBox(
              height: h * 0.03,
            ),
            Expanded(
              child: FutureBuilder(
                  future: _alarms,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView(
                            children: snapshot.data!.map<Widget>((alarm) {
                              // var alarmTime = DateFormat('HH:mm:aa')
                              //     .format(alarm.alarmDateTime);
                              var newtime = alarm.alarmDateTime;
                              return Container(
                                margin: EdgeInsets.only(bottom: h * 0.03),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 166, 106, 28)
                                            .withOpacity(0.25),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                        offset: const Offset(
                                          4,
                                          4,
                                        ),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(22),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Color.fromARGB(255, 38, 38, 38),
                                      ],
                                      begin: Alignment.center,
                                      end: Alignment.topRight,
                                    )),
                                // Customize the container based on your needs
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.label,
                                            size: h * 0.03,
                                            color: Colors.orange[300],
                                          ),
                                          SizedBox(
                                            width: w * 0.04,
                                          ),
                                          Text(
                                            alarm.title!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: h * 0.025),
                                          ),
                                          const Spacer(),
                                          Switch(
                                              activeColor: Colors.white,
                                              value: true,
                                              onChanged: (bool value) {}),
                                        ],
                                      ),
                                      Text(
                                        'Mon-Fri',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: h * 0.02),
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            DateFormat.jm()
                                                .format(newtime!)
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: h * 0.025),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              _alarmHelper.delete(alarm.id);
                                              loadAlarms();
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: h * 0.035,
                                            ),
                                          ),
                                          SizedBox(
                                            width: w * 0.04,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: h * 0.01,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).followedBy([
                              // if (_currentAlarms.length < 5)
                              DottedBorder(
                                strokeWidth: 2,
                                color: Colors.white,
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(24),
                                dashPattern: const [5, 4],
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                  ),
                                  child: MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                    onPressed: () {
                                      _alarmTimeString = DateFormat.jm()
                                          .format(DateTime.now());
                                      showModalBottomSheet(
                                        useRootNavigator: true,
                                        context: context,
                                        clipBehavior: Clip.antiAlias,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(24),
                                          ),
                                        ),
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setModalState) {
                                              return Container(
                                                height: h * 0.4,
                                                padding:
                                                    const EdgeInsets.all(32),
                                                child: Column(
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        var selectedTime =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (selectedTime !=
                                                            null) {
                                                          final now =
                                                              DateTime.now();
                                                          var selectedDateTime =
                                                              DateTime(
                                                                  now.year,
                                                                  now.month,
                                                                  now.day,
                                                                  selectedTime
                                                                      .hour,
                                                                  selectedTime
                                                                      .minute);
                                                          _alarmTime =
                                                              selectedDateTime;
                                                          setModalState(() {
                                                            _alarmTimeString =
                                                                DateFormat.jm()
                                                                    .format(
                                                                        selectedDateTime);
                                                          });
                                                        }
                                                      },
                                                      child: Text(
                                                        _alarmTimeString,
                                                        style:
                                                            GoogleFonts.oswald(
                                                          letterSpacing: 1,
                                                          fontSize: h * 0.045,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        'Repeat',
                                                        style:
                                                            GoogleFonts.kanit(
                                                          letterSpacing: 1,
                                                          fontSize: h * 0.03,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      trailing: Switch(
                                                        onChanged: (value) {
                                                          setModalState(() {
                                                            _isRepeatSelected =
                                                                value;
                                                          });
                                                        },
                                                        value:
                                                            _isRepeatSelected,
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        'Sound',
                                                        style:
                                                            GoogleFonts.kanit(
                                                          letterSpacing: 1,
                                                          fontSize: h * 0.03,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      trailing: const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    FloatingActionButton
                                                        .extended(
                                                      backgroundColor:
                                                          Colors.orange[300],
                                                      onPressed: () {
                                                        saveAlarm(
                                                          _isRepeatSelected,
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.alarm,
                                                        color: Colors.black,
                                                        size: h * 0.035,
                                                      ),
                                                      label: Text(
                                                        'Save',
                                                        style:
                                                            GoogleFonts.kanit(
                                                                letterSpacing:
                                                                    1,
                                                                fontSize:
                                                                    h * 0.03,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                      // scheduleAlarm();
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/icons/add_alarm.png',
                                          scale: 1.5,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Add Alarm',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: h * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]).toList(),
                          )
                        : const Center(
                            child: Text(
                            'Loading',
                            style: TextStyle(color: Colors.white),
                          ));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void saveAlarm(
    bool _isRepeating,
  ) {
    // var correctTime=Da
    DateTime? schduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now())) {
      schduleAlarmDateTime = _alarmTime;
    } else {
      schduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));
      var alarmInfo = AlarmInfo(
          alarmDateTime: schduleAlarmDateTime,
          gradientColorIndex: 10,
          title: 'Alarm',
          id: int.parse(DateTime.now().second.toString()));
      _alarmHelper.insertAlarm(alarmInfo);
      if (schduleAlarmDateTime != null) {
        scheduleAlarm(schduleAlarmDateTime, alarmInfo, isRepeating: true);
      }

      Navigator.pop(context);
      loadAlarms();

      NotificationServices().sendNotification(
          0,
          _alarmTimeString = DateFormat.jm().format(schduleAlarmDateTime),
          'Alarm has been Set');
    }
  }
}

void scheduleAlarm(DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo,
    {required bool isRepeating}) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'channelId',
    'channelName',
    importance: Importance.max,
    largeIcon: DrawableResourceAndroidBitmap('timer'),
    styleInformation: BigPictureStyleInformation(
      DrawableResourceAndroidBitmap('Clock'),
      hideExpandedLargeIcon: true,
    ),
  );
}
