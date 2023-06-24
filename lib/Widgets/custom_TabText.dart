import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabText extends StatelessWidget {
  final String text;
  Color color;
  TabText({
    required this.text,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Tab(
      child: Text(
        text,
        style: GoogleFonts.righteous(
          letterSpacing: 2,
          fontSize: h * 0.027,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
