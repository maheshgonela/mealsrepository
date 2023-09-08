import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

AppBar appbar(BuildContext context) {
  return AppBar(
   // backgroundColor:Colors.black,
    leading: null,
    title: Row(
      children: [
        SizedBox(
          width: 20,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Color.fromARGB(255, 240, 3, 3),
              fontSize: 30,
              fontWeight: FontWeight.w900,
              fontFamily: GoogleFonts.newRocker(fontSize: 0).fontFamily,
            ),
            children: <TextSpan>[
              TextSpan(
                text: "Meal",
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 11, 11),
                ),
              ),
              TextSpan(
                text: " Maven",
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
