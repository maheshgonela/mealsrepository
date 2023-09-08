import 'package:flutter/material.dart';

Card mealquantitydisplay(totallunchcount, food_multiplier, BuildContext context,
    meal_quantity, guestcount) {
  return Card(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(8, 230, 193, 1),
        // borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Meal quantity ( (${totallunchcount}+${guestcount}) x ${food_multiplier} )",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              " => ",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 17,
                  ),
            ),
          ),
          Text(
            "$meal_quantity",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                ),
          ),
        ],
      ),
    ),
  );
}
