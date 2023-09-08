import 'package:flutter/material.dart';
import 'package:lunch_app/home/home_page_buttons.dart';

Row adminbottombar(
    BuildContext context, totallunchcount, totaleggcount, meal_quantity,
    {VoidCallback? onPress}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // we used "false , false" for balanceing buttons like copy and yes btns
      homebuttons(1, context, false, false, totallunchcount.toString(),
          totaleggcount.toString(), meal_quantity),

      homebuttons(3, context, false, false, totallunchcount.toString(),
          totaleggcount.toString(), meal_quantity),

      homebuttons(4, context, false, false, totallunchcount.toString(),
          totaleggcount.toString(), meal_quantity),
          
           homebuttons(2, context, false, false, totallunchcount.toString(),
          totaleggcount.toString(), meal_quantity),
    ],
  );
}
