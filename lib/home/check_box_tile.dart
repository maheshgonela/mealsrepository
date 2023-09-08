import 'package:flutter/material.dart';

class CheckBoxtile extends StatelessWidget {
  final bool initialvalue;
  final bool enabled;
  final void Function(bool? value) onchnage;
  final String title;

  const CheckBoxtile(
      {super.key,
      required this.initialvalue,
      required this.onchnage,
      required this.enabled,
      required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      child: CheckboxListTile(
        value: initialvalue,
        enabled: enabled,
        activeColor: Color.fromARGB(255, 107, 124, 252),
        onChanged: onchnage,
        checkboxShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: BorderSide(color: Colors.black, width: 2.5),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 23,
                color: Colors.black,
              ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
