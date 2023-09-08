
import 'package:flutter/material.dart';

Row userbottombar(BuildContext context,usertextbar) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 50,
      ),
      Text(
        '$usertextbar',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 21,
             color: Color.fromARGB(255, 248, 19, 2),
            ),
      ),
    ],
  );
}