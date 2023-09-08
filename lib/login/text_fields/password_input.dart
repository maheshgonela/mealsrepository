import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

TextField Password_input(
  _passwordVisible,
  _passwordController,
  BuildContext context,
  {VoidCallback? onPress}
) {
  return TextField(
    obscureText: _passwordVisible,
    controller: _passwordController,
    keyboardType: TextInputType.visiblePassword,
    style: TextStyle(color: Color.fromARGB(255, 6, 6, 6)),
    decoration: InputDecoration(
      labelText: ' Password ',
      labelStyle: GoogleFonts.lato(
          fontWeight: FontWeight.w500, fontSize: 25, color: Colors.black),
      hintText: 'Enter your password',
      hintStyle: GoogleFonts.lato(
          fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),
      fillColor: Color.fromARGB(255, 222, 224, 225),
      filled: true,
      prefixIcon: Icon(
        Icons.password_sharp,
        color: Color.fromARGB(255, 10, 9, 9),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25), gapPadding: 5),
      suffixIcon: IconButton(
        onPressed: () {
         onPress?.call();
        },
        icon: Icon(
          _passwordVisible ? Icons.visibility : Icons.visibility_off,
        ),
      ),
    ),
  );
}
