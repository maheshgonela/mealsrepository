import 'package:flutter/material.dart';
import 'package:lunch_app/home/home_page_buttons.dart';

Row yesbtnandtext(
    int buttonNamesIndex,
    BuildContext context,
    bool _lunchisChecked,
    bool _eggisChecked,
    totallunchcount,
    totaleggcount,
    listtext,
    meal_quantity,
    {VoidCallback? onPress}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        listtext,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 28,
              color: Colors.black,
            ),
      ),
      SizedBox(
        width: 10,
      ),
      homebuttons(
        0,
        context,
        _lunchisChecked,
        _eggisChecked,
        null,
        null,
        meal_quantity,
        onPress: () {
          onPress?.call();
        },
      ),
    ],
  );
}
