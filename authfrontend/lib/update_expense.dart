import 'dart:convert';
import 'package:authfrontend/list_expense.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'expense.dart';

class EditExpenseScreen extends StatefulWidget {
  final int id;
  final Function onExpenseUpdated;

  EditExpenseScreen({required this.id, required this.onExpenseUpdated});

  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  set expenses(List<Expense> expenses) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => updateExpense(context, widget.id),
                child: Text('Edit Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateExpense(BuildContext context, int id) async {
    final url = 'http://127.0.0.1:8000/api/updateexpense/';
    final expense = Expense(
      id: id,
      title: _titleController.text,
      description: _descriptionController.text,
      amount: int.parse(_amountController.text),
      category: _categoryController.text,
    );
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': id.toString(),
        'title': _titleController.text,
        'description': _descriptionController.text,
        'amount': _amountController.text,
        'category': _categoryController.text,
      },
    );

    if (response.statusCode == 200) {
      widget.onExpenseUpdated();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ExpenseListScreen()));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update expense'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }
}
