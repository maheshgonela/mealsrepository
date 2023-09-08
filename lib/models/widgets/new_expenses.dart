import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunch_app/models/widgets/expenses_list/expense_data.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({
    super.key,
    required this.onAddExpenses,
  });

  final void Function(Expense expense) onAddExpenses;

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

final List<String> registeredExpense = [];

class _NewExpensesState extends State<NewExpenses> {
  var now = DateTime.now();
 
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _SelectedDate = DateTime(0000, 00, 00, 00, 00, 00);
  Category _SelectedCatagory = Category.food;
  

  void _saveExpensesData() {
    final enterdAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enterdAmount == null || enterdAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _SelectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('invalid input'),
          content:
              const Text('please make sure with a valid title,amount,and date'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("okey"),
            ),
          ],
        ),
      );
      return;
    }

   String formattedDateTime = DateFormat('yyyy-MM-dd').format(_SelectedDate);
    widget.onAddExpenses(
      Expense(
        id: uuid.v4(),
        Descriptions: _titleController.text,
        amount: enterdAmount,
        date: formattedDateTime,
        category: _SelectedCatagory,
      ),
    );
    Navigator.pop(context);
  }


  Future<void> forExpenses_adding() async {
   

    final user = FirebaseAuth.instance.currentUser;
    final user_email = user?.email;

    String formattedDateTime = DateFormat('yyyy-MM-dd').format(_SelectedDate);
     //String DateTime='${now.year}-${now.month}' ;
    await FirebaseFirestore.instance
        .collection('expenses_${now.month}-${now.year}')
        //.doc()
        .add({
      'description': _titleController.text,
      'amount': double.parse(_amountController.text),
      'category': _SelectedCatagory.name,
      'expensesDate': formattedDateTime,
      'admin': user_email,
      'currentDate': "${now.day}-${now.month}-${now.year}",
    });
  }

  Map<String, dynamic>? data;
  void readDataFromFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('expenses').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          data = documentSnapshot.data() as Map<String, dynamic>?;
          print(data);
        }
      } else {
        print('No documents found.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _presentDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _SelectedDate = pickedDate!;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // readDataFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 100,
            decoration: InputDecoration(
              label: Text("Description"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("Amount"),
                    prefixText: '\₹ ',
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _SelectedDate == null
                          ? '00/00/202_'
                          : formatter.format(_SelectedDate),
                    ),
                    IconButton(
                      onPressed: () {
                        _presentDate();
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton<Category>(
                  value: _SelectedCatagory,
                  items: Category.values
                      .map(
                        (Category) => DropdownMenuItem(
                          value: Category,
                          child: Text(
                            Category.name.toLowerCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _SelectedCatagory = value;
                    });
                  }),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  _saveExpensesData();

                  await forExpenses_adding();
                },
                child: Text("save"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
