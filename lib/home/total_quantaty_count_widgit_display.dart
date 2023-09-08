import 'package:flutter/material.dart';
import 'package:lunch_app/home/date_time.dart';
import 'package:lunch_app/home/food_quantity.dart';
import 'package:lunch_app/home/food_true_list.dart';
import 'package:lunch_app/home/egg_true_list.dart';
import 'package:lunch_app/home/guest_display.dart';
import 'package:lunch_app/home/meal_quantity_display.dart';

Container Totalquantatydisplay(
    BuildContext context, totallunchcount, totaleggcount,
    meal_quantity,
    food_multiplier,
   [ guestcount,
     fixedTime,
    Future<void> Function()? guestlunchremovecount,Future<void> Function()? fetchtotalguestcount]) {
  return Container(
    width: 350,
    margin: EdgeInsets.only(
      top: 20,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total food quantity",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 21,
                  ),
            ),
            Row(
              children: [Current_Date(context)],
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Quantitywidget(
            quantityIndex: 0,
            totallunchandeggcount: totallunchcount.toString(),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => foodtruelist()));
            }),
        SizedBox(
          height: 20,
        ),
        Quantitywidget(
            quantityIndex: 1,
            totallunchandeggcount: totaleggcount.toString(),
            onTap: () {
              Navigator.push(
                  context, //----------------->here egg true view page
                  MaterialPageRoute(builder: (context) => eggtruelist()));
            }),
        SizedBox(
          height: 20,
        ),
        guest_display(guestcount: guestcount,guestlunchremovecount: guestlunchremovecount,fetchtotalguestcount: fetchtotalguestcount,fixedTime: fixedTime ),//,fixedTime: fixedTime
        SizedBox(
          height: 20,
        ),
        mealquantitydisplay(totallunchcount, food_multiplier, context,
            meal_quantity, guestcount),
      ],
    ),
  );
}
