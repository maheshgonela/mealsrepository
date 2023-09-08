import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
final uuid = Uuid();

enum Category { food, egg, extra }

Category nameToCategory(String name) {
  if (name == 'food') return Category.food;
  if (name == 'egg') return Category.egg;
  if (name == 'extra') return Category.extra;
  return Category.food;
}

const CategoryIcon = {
  Category.food: Icons.lunch_dining_rounded,
  Category.egg: Icons.egg_rounded,
  Category.extra: Icons.dining,
};

class Expense {
  String? id;
  final String Descriptions;
  final double amount;
  final String date;
  final Category category;

  Expense({
    required this.Descriptions,
    required this.amount,
    required this.date,
    required this.category,
    this.id,
  });
}
