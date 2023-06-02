import 'dart:convert';
import 'package:authfrontend/update_expense.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'add_expense.dart';
import 'expense.dart';

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  List<Expense> expenses = [];

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  void fetchExpenses() async {
    final url = 'http://127.0.0.1:8000/api/listexpense/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> jsonData = responseData['expenses'];

      setState(() {
        expenses = jsonData.map((data) => Expense.fromJson(data)).toList();
      });
    } else {
      // Handle error
    }
  }

  Future<void> deleteExpense(int id) async {
    final url = 'http://127.0.0.1:8000/api/deleteexpense/';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': id.toString(),
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        expenses.removeWhere((expense) => expense.id == id);
      });
    } else {
      // Handle error
    }
  }

  void navigateToUpdateForm(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditExpenseScreen(
          id: id,
          onExpenseUpdated: onExpenseUpdated,
        ),
      ),
    );
  }

  void onExpenseUpdated() {
    setState(() {
      fetchExpenses(); // Refresh the expense list after an update
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (BuildContext context, int index) {
          final expense = expenses[index];
          return ListTile(
            title: Text(expense.description),
            subtitle: Text('KES${expense.amount.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => navigateToUpdateForm(expense.id),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteExpense(expense.id),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
