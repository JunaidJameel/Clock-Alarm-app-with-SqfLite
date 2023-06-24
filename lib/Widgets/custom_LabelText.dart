import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLabelText extends StatelessWidget {
  final String customLabelText;
  final double fontsize;
  const CustomLabelText({
    super.key,
    required this.customLabelText,
    required this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Text(
      customLabelText,
      style: GoogleFonts.figtree(
          fontWeight: FontWeight.w600, fontSize: fontsize, color: Colors.white),
    );
  }
}
