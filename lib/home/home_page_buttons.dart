import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lunch_app/expensive_tracker/expensive_widget.dart';
import 'package:lunch_app/meal_egg_data_display/egg_monthly_data_display.dart';
import 'package:lunch_app/meal_egg_data_display/meal_monthly_data_display.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';

List buttonNames = ['yes', '', '', '', ''];
CollectionReference lunch = FirebaseFirestore.instance
    .collection('lunch_${now.day}-${now.month}-${now.year}');
var now = DateTime.now();

Widget homebuttons(
    int buttonNamesIndex,
    BuildContext context,
    bool _lunchisChecked,
    bool _eggisChecked,
    totallunchcount,
    totaleggcount,
    meal_quantity,
    {VoidCallback? onPress}) {
  if (buttonNamesIndex == 1) {
    return IconButton(
      onPressed: () async {
        await Share.share("Lunch : ${meal_quantity}");
      },
      icon: Icon(
        Icons.share,
        size: 28,
        color: Colors.white,
      ),
    );
  } else if (buttonNamesIndex == 2) {
    return IconButton(
      onPressed: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ExpensiveWidget()));
      },
      icon: Icon(
        Icons.account_balance_wallet,
        size: 34,
        color: Colors.white,
      ),
    );
  } else if (buttonNamesIndex == 3) {
    return IconButton(
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Meal_monthly_data_display()));
      },
      icon: Icon(
        Icons.ramen_dining,
        size: 34,
        color: Colors.white,
      ),
    );
  } else if (buttonNamesIndex == 4) {
    return IconButton(
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Egg_monthly_data_display()));
      },
      icon: Icon(
        Icons.egg,
        size: 36,
        color: Colors.white,
      ),
    );
  } else {
    return ElevatedButton(
      style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(
            GoogleFonts.lato(
              fontSize: 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: MaterialStatePropertyAll(4),
          backgroundColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 200, 192, 234)),
          padding: MaterialStatePropertyAll(EdgeInsets.all(4)),
          minimumSize: MaterialStatePropertyAll(Size(20, 20))),
      onPressed: () async {
        await callbackforyes(
            buttonNamesIndex, context, _lunchisChecked, _eggisChecked);
        // Handle the result here
        onPress?.call();
      },
      child: Text(
        buttonNames[buttonNamesIndex],
        style: TextStyle(
          color: Colors.black87, // text color
        ),
      ),
    );
  }
}

Future<void> callbackforyes(int buttonNamesIndex, BuildContext context,
    _lunchisChecked, _eggisChecked) async {
  if (buttonNamesIndex == 0) {
    Toast.show("Successfully Updated!😄",
        duration: Toast.lengthShort,
        gravity: Toast.top,
        backgroundColor: Color.fromARGB(255, 93, 5, 35));

    final user = FirebaseAuth.instance.currentUser;
    var user_email = user!.email!;
    lunch.add({
      'egg': _eggisChecked,
      'lunch': _lunchisChecked,
      'email': user_email,
      'date': "${now.day}-${now.month}-${now.year}",
      //'Guest':null,
    });
  }
}
