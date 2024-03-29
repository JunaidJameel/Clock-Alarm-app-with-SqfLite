import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timer/Model/alarm_info.dart';

class AlarmHelper {
  static Database? _database;
  static AlarmHelper? _alarmHelper;

  final String tableAlarm = 'alarm';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnDateTime = 'alarmDateTime';
  final String columnPending = 'isPending';
  final String columnColorIndex = 'gradientColorIndex';
  AlarmHelper._createInstance();
  factory AlarmHelper() {
    _alarmHelper = AlarmHelper._createInstance();
    return _alarmHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'alarm.db');

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $tableAlarm(
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
            $columnDateTime TEXT NOT NULL,
            $columnPending INTEGER,
            $columnColorIndex INTEGER
          )
        ''');
      },
    );

    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await database;
    var result = await db.insert(tableAlarm, alarmInfo.toMap());
    print('result : $result');
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int? id) async {
    var db = await database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}
