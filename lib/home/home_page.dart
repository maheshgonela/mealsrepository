import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lunch_app/resources/Drawer_Widget.dart';
import 'package:lunch_app/home/app_bar_dispaly.dart';
import 'package:lunch_app/home/bottombarcontant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lunch_app/home/time_out_display.dart';
import 'package:lunch_app/home/total_quantaty_count_widgit_display.dart';
import 'package:lunch_app/home/yes_text_list_display.dart';

import 'package:toast/toast.dart';
import 'package:lunch_app/home/check_box_tile.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _lunchisChecked = false;
  bool _eggisChecked = false;
  bool _isLunchProvided = false;
  bool isSunday = DateTime.now().weekday == DateTime.sunday;
  int fixedTime = 11; // but 11
  List<String> _list = ['Lock Cheyyala ? ', 'Lock Karna Kya ?'];
  int _currentIndex = 0;
  var now = DateTime.now();
  late Timer timer;
  final food_multiplier =
      FirebaseRemoteConfig.instance.getDouble('food_multiplier');

  void usertesting() {
    final user = FirebaseAuth.instance.currentUser;
    var email = user!.email!;
    FirebaseFirestore.instance
        .collection('lunch_${now.day}-${now.month}-${now.year}')
        .where('date', isEqualTo: '${now.day}-${now.month}-${now.year}')
        .where('email', isEqualTo: email)
        .get()
        .then(
      (Snap) {
        if (Snap.size == 0) {
          _isLunchProvided = false;
          setState(() {});
        } else {
          _isLunchProvided = true;
          _lunchisChecked = Snap.docs.first['lunch'] as bool;
          _eggisChecked = Snap.docs.first['egg'] as bool;
          timer.cancel();
          setState(() {});
        }
      },
    );
  }

  Future<void> deleteDuplicates() async {
    final CollectionReference collection = FirebaseFirestore.instance
        .collection('lunch_${now.day}-${now.month}-${now.year}');

    QuerySnapshot querySnapshot = await collection.orderBy('email').get();

    String? lastEmail;

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      final email = document['email'];

      if (email == lastEmail) {
        await collection.doc(document.id).delete();
      } else {
        lastEmail = email;
      }
    }
  }

  var totallunchcount = 0;
  Future<void> fortotallunch() async {
    FirebaseFirestore.instance
        .collection('lunch_${now.day}-${now.month}-${now.year}')
        .where('date', isEqualTo: '${now.day}-${now.month}-${now.year}')
        .where('lunch', isEqualTo: true)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        totallunchcount = querySnapshot.size;

        roundFigure();
        setState(() {});
      },
    );
  }

  var guestcount = 0;
  Future<void> fetchtotalguestcount() async {
    FirebaseFirestore.instance
        .collection('lunch_${now.day}-${now.month}-${now.year}')
        .where('date', isEqualTo: '${now.day}-${now.month}-${now.year}')
        .where('guestlunch', isEqualTo: true)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        guestcount = querySnapshot.size;
        roundFigure();
        setState(() {});
      },
    );
  }

  final CollectionReference lunchtoday = FirebaseFirestore.instance.collection(
      'lunch_${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');

  Future<void> guestlunchremovecount() async {
    QuerySnapshot querySnapshot = await lunchtoday
        .where('date', isEqualTo: '${now.day}-${now.month}-${now.year}')
        .where('guestlunch', isEqualTo: true)
        .orderBy(FieldPath.documentId)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      String documentId = querySnapshot.docs.first.id;
      await lunchtoday.doc(documentId).delete();
      Toast.show("Removed Successfully 👍",
          duration: Toast.lengthShort, gravity: Toast.bottom);
    } else {}
  }

  int meal_quantity = 0;
  void roundFigure() {
    meal_quantity = ((totallunchcount + guestcount) * food_multiplier).round();
    setState(() {});
  }

  var totaleggcount = 0;
  Future<void> fortotalegg() async {
    FirebaseFirestore.instance
        .collection('lunch_${now.day}-${now.month}-${now.year}')
        .where('date', isEqualTo: '${now.day}-${now.month}-${now.year}')
        .where('egg', isEqualTo: true)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        totaleggcount = querySnapshot.size;

        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    usertesting();
    fortotallunch();
    fortotalegg();
    fetchtotalguestcount();
    deleteDuplicates();
    ToastContext().init(context);
    timer = Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        setState(
          () {
            _currentIndex = (timer.tick + 1) % _list.length;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email!;
    }
    var now = DateTime.now();
    return Scaffold(
      appBar: appbar(context),
      drawer: NavigationDrawerWidget(user),
      body: RefreshIndicator(
        onRefresh: () async {
          fortotallunch();
          fortotalegg();

          return Future.delayed(Duration(milliseconds: 1500));
        },
        displacement: 5,
        backgroundColor: Colors.black87,
        color: Color.fromARGB(255, 248, 19, 2),
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: 200,
                height: 180,
                margin: EdgeInsets.only(top: 50, bottom: 50),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(191, 226, 220, 1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            CheckBoxtile(
                              initialvalue: _lunchisChecked,
                              enabled:
                                  !_isLunchProvided && now.hour < fixedTime,
                              title: "Lunch",
                              onchnage: (value) {
                                setState(() {
                                  _lunchisChecked = value!;
                                });
                              },
                            ),
                            CheckBoxtile(
                              initialvalue: _eggisChecked,
                              enabled:
                                  !_isLunchProvided && now.hour < fixedTime,
                              title: "Egg",
                              onchnage: (value) {
                                setState(() {
                                  _eggisChecked = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(191, 226, 220, 1),
                  ),
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: Column(
                    children: [
                      if (isSunday != true)
                        if (now.hour < fixedTime)
                          if (!_isLunchProvided)
                            yesbtnandtext(
                              0,
                              context,
                              _lunchisChecked,
                              _eggisChecked,
                              null,
                              null,
                              _list[_currentIndex],
                              meal_quantity,
                              onPress: () {
                                usertesting();
                                fortotallunch();
                                fortotalegg();
                              },
                            ),
                      if (now.hour >= fixedTime) timeoutwidget(context),
                      if (isSunday == true) timeoutwidget(context),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Totalquantatydisplay(
                  context,
                  totallunchcount,
                  totaleggcount,
                  meal_quantity,
                  food_multiplier,
                  guestcount,
                  fixedTime,
                  guestlunchremovecount,
                  fetchtotalguestcount),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Column(
          children: [
            Container(
              height: 56,
              child: Card(
                margin: EdgeInsets.only(left: 10, right: 10),
                color: Colors.black87,
                child: Container(
                  padding:
                      EdgeInsets.only(top: 3, bottom: 3, left: 4, right: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Bottomappbarcontant(
                          context,
                          totallunchcount.toString(),
                          totaleggcount.toString(),
                          meal_quantity,
                          _isLunchProvided,
                          fixedTime,
                          fetchtotalguestcount()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
