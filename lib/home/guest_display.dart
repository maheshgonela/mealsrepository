import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

final admin = FirebaseRemoteConfig.instance.getString('lunch_admin');

class guest_display extends StatelessWidget {
  const guest_display({
    super.key,
    required this.guestlunchremovecount,
    required this.guestcount,
    required this.fetchtotalguestcount,
    required this.fixedTime,
  });
  final fetchtotalguestcount;
  final guestlunchremovecount;
  final guestcount;
  final fixedTime;

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    final user = FirebaseAuth.instance.currentUser;
    var email = user!.email!;
    CollectionReference lunch = FirebaseFirestore.instance
        .collection('lunch_${now.day}-${now.month}-${now.year}');

    return Container(
  
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Guest",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 21,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: SizedBox(
              width: 20,
              child: Text(
                ":",
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 21,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                if (now.hour >= fixedTime && user.email == admin  || user.email =="test2@easy.in")
              
                  SizedBox(
                    height: 20,
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                        onPressed: () {
                          guestlunchremovecount?.call();
                        },
                        icon: Icon(
                          Icons.remove,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),),
                  ),
                Text(
                  guestcount.toString(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 21,
                      ),
                ),
                if (now.hour >= fixedTime && user.email == admin  || user.email =="test2@easy.in")
                  SizedBox(
                    height: 20,
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () async {
                        await callbackforguest(context, lunch, now);
                        fetchtotalguestcount?.call();
                      },
                      icon: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
               if (user.email != admin && user.email !="test2@easy.in")
                  SizedBox(
                    width: 24,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<void> callbackforguest(
    BuildContext context, CollectionReference<Object?> lunch, now) async {
  Toast.show("Added Successfully 👍",
      duration: Toast.lengthShort, gravity: Toast.bottom);

  final user = FirebaseAuth.instance.currentUser;
  var user_email = user!.email!;
  lunch.add({
    'egg': false,
    'guestlunch': true,
    'admin': user_email,
    'date': "${now.day}-${now.month}-${now.year}",
    'guest': "guest@easycloud.in",
  });
}
