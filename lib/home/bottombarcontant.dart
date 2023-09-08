import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:lunch_app/home/admin_bottom_bar.dart';
import 'package:lunch_app/home/home_page_buttons.dart';
import 'package:lunch_app/home/user_bottom_bar.dart';

Widget Bottomappbarcontant(BuildContext context, totallunchcount, totaleggcount,
    meal_quantity, isLunchProvided, fixedTime,
    [Future<void>? guestlunchaddcount]) {
  //
  final user = FirebaseAuth.instance.currentUser;

  final admin = FirebaseRemoteConfig.instance.getString('lunch_admin');
  if (now.hour >= fixedTime && user?.email == admin || user?.email =="test2@easy.in") {
    return adminbottombar(
      context,
      totallunchcount,
      totaleggcount,
      meal_quantity,
      onPress: () => guestlunchaddcount,
    );
  } else if (now.hour < fixedTime) {
    if (isLunchProvided) {
      return userbottombar(context, "successfully Updated 😁😀");
    } else {
      return userbottombar(context, "you have to update the food 🥱😋");
    }
  } else if (now.hour >= fixedTime) {
    if (isLunchProvided) {
      return userbottombar(context, "successfully Updated 😁😀");
    } else {
      return userbottombar(context, "you missed the lunch 😶😌");
    }
  } else {
    return SizedBox();
  }
}
