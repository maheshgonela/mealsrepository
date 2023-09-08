import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class MealCount {
  final int date;
  final int meal_quantity;
  MealCount(this.date, this.meal_quantity);
  static int calculateSum(List<MealCount> mealCounts) {
    int total_meal_quantity = 0;
    for (var mealCount in mealCounts) {
      total_meal_quantity += mealCount.meal_quantity;
    }
    return total_meal_quantity;
  }
}

class Meal_monthly_data_display extends StatefulWidget {
  Meal_monthly_data_display({super.key});
  @override
  State<Meal_monthly_data_display> createState() =>
      _Meal_monthly_data_displayState();
}

class _Meal_monthly_data_displayState extends State<Meal_monthly_data_display> {
  bool isLoading = false;
  final food_multiplier =
      FirebaseRemoteConfig.instance.getDouble('food_multiplier');
  List<MealCount> mealCounts = [];

  late int meal_quantity;
  Future<void> fortotallunch(int day) async {
    if (day <= now.day) {
      int l1 = await getStaffLunchCount(day);
      int l2 = await getGuestLunchCount(day);
      if ((l1 + l2) != 0) {
        int meal_day = day;
        meal_quantity = ((l1 + l2) * food_multiplier).round();
        mealCounts.add(MealCount(meal_day, meal_quantity));
      }
    }
  }

  /// we have to remove month parameter
  Future<int> getStaffLunchCount(int day) async {
    int count = 0;
    await FirebaseFirestore.instance
        .collection('lunch_${day}-${now.month}-${now.year}')
        .where('date', isEqualTo: '${day}-${now.month}-${now.year}')
        .where('lunch', isEqualTo: true)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        if (querySnapshot.size == 0) return;
        count = querySnapshot.size;
      },
    );
    return count;
  }

  /// we have to remove month parameter
  Future<int> getGuestLunchCount(int day) async {
    int count = 0;
    await FirebaseFirestore.instance
        .collection('lunch_${day}-${now.month}-${now.year}')
        .where('date', isEqualTo: '${day}-${now.month}-${now.year}')
        .where('guestlunch', isEqualTo: true)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        if (querySnapshot.size == 0) return;
        count = querySnapshot.size;
      },
    );
    return count;
  }

  int total_meal_quantity = 0;
  void forsorting() async {
    int lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;
    for (int i = 1; i <= lastDayOfMonth; i++) {
      await fortotallunch(i);
    }

    total_meal_quantity = MealCount.calculateSum(mealCounts);
    // print('Sum: $total_meal_quantity');
    mealCounts.sort((a, b) => a.date.compareTo(b.date));
    setState(() {
      isLoading = false;
    });
  }

  void initState() {
    super.initState();
    forsorting();
    isLoading = true;
  }

// int total_meal_quantity = mealCounts.fold(0, (previousValue, element) => previousValue + element.meal_quantity);

  var now = DateTime.now();
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal quantity'),
        backgroundColor: Colors.black87,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: mealCounts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  child: Card(
                    color: Colors.tealAccent[100],
                    child: Container(
                      padding: EdgeInsets.all(4),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.ramen_dining,
                                size: 30,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${mealCounts[index].meal_quantity}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 20,
                                    ),
                              ),
                            ],
                          ),
                          Text(
                            "${mealCounts[index].date}-${now.month}-${now.year}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 19,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: Color.fromRGBO(191, 226, 220, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total monthly meal count : $total_meal_quantity 🍜",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 21,
                      color: Colors.black87,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
