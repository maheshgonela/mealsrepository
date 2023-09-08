import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

TextField Email_input(_editingController) {
  return TextField(
    controller: _editingController,
    keyboardType: TextInputType.name,
    decoration: InputDecoration(
      labelText: ' Email address',
      labelStyle: GoogleFonts.lato(
          fontWeight: FontWeight.w500, fontSize: 25, color: Colors.black),
      hintText: 'Enter your email address',
      hintStyle: GoogleFonts.lato(
          fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),
      fillColor: Color.fromARGB(255, 222, 224, 225),
      filled: true,
      prefixIcon: Icon(
        Icons.person_3_rounded,
        color: Color.fromARGB(255, 3, 3, 3),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25), gapPadding: 5,borderSide: BorderSide(color: Colors.red)),
    ),
    cursorColor: Colors.red,
  );
}
