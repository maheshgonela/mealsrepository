import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class EggCount {
  final int date;
  final int egg_num;
  EggCount(this.date, this.egg_num);
  static int calculateSum(List<EggCount> mealCounts) {
    int total_meal_quantity = 0;
    for (var EggCount in mealCounts) {
      total_meal_quantity += EggCount.egg_num;
    }
    return total_meal_quantity;
  }
}

class Egg_monthly_data_display extends StatefulWidget {
  Egg_monthly_data_display({super.key});
  @override
  State<Egg_monthly_data_display> createState() =>
      _Egg_monthly_data_displayState();
}

class _Egg_monthly_data_displayState extends State<Egg_monthly_data_display> {
  bool isLoading = false;
  final food_multiplier =
      FirebaseRemoteConfig.instance.getDouble('food_multiplier');
  List<EggCount> EggCounts = [];

  var now = DateTime.now();
  late int egg_num;
  Future<void> fortotalegg(int day) async {
    if (day <= now.day) {
      int l1 = await getStaffEggCount(day);
      if ((l1) != 0) {
        int egg_day = day;
        egg_num = (l1);
        EggCounts.add(EggCount(egg_day, egg_num));
      }
    }
  }

  /// we have to remove month parameter
  Future<int> getStaffEggCount(int day) async {
    int count = 0;
    await FirebaseFirestore.instance
        .collection('lunch_${day}-${now.month}-${now.year}')
        .where('date', isEqualTo: '${day}-${now.month}-${now.year}')
        .where('egg', isEqualTo: true)
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
      await fortotalegg(i);
    }
    total_meal_quantity = EggCount.calculateSum(EggCounts);
    //print('Sum: $total_meal_quantity');
    EggCounts.sort((a, b) => a.date.compareTo(b.date));
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

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Egg Count'),
        backgroundColor: Colors.black87,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: EggCounts.length,
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
                                Icons.egg,
                                size: 30,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${EggCounts[index].egg_num}',
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
                            "${EggCounts[index].date}-${now.month}-${now.year}",
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
                "Total monthly egg count : $total_meal_quantity 🥚",
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
