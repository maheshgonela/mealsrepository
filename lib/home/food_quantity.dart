import 'package:flutter/material.dart';

List quantity = ['Total Lunch', "Total Egg  "];

// Row totalquantity(
//     int quantityIndex, BuildContext context, String _totallunchandeggcount) {
//   return Quantitywidget();
// }

class Quantitywidget extends StatelessWidget {
  const Quantitywidget({
    super.key,
    required this.quantityIndex,
    required this.totallunchandeggcount,
    this.onTap,
  });

  final int quantityIndex;
  final String totallunchandeggcount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(
              quantity[quantityIndex],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 21,
                  ),
            ),
          ),
          SizedBox(
            width: 20,
            child: Text(
              ":",
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 21,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              totallunchandeggcount,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 21,
                  ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}
