import 'package:flutter/material.dart';
import 'package:lunch_app/models/widgets/expenses_list/expense_data.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Text(expense.Descriptions),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('\₹ ${expense.amount}'),
               const Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcon[expense.category],),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                     expense.date,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
