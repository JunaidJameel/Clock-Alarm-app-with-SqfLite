import 'package:flutter/material.dart';

class AlarmInfo {
  int? id;
  final String? title;
  late final DateTime? alarmDateTime;
  final bool? isPending;
  int? gradientColorIndex;

  AlarmInfo({
    this.alarmDateTime,
    this.gradientColorIndex,
    this.id,
    this.isPending,
    this.title,
  });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) {
    return AlarmInfo(
      id: json["id"],
      title: json["title"],
      alarmDateTime: DateTime.parse(json["alarmDateTime"]),
      isPending: json["isPending"],
      gradientColorIndex: json["gradientColorIndex"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "alarmDateTime": alarmDateTime!.toIso8601String(),
      "isPending": isPending,
      "gradientColorIndex": gradientColorIndex,
    };
  }
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}
