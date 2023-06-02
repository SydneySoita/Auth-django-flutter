import 'package:authfrontend/add_expense.dart';
import 'package:authfrontend/list_expense.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class HomepageScreen extends StatelessWidget {
  void loginUser(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void addexpense(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddExpenseScreen()));
  }

  void viewexpense(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ExpenseListScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage')),
      body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => loginUser(context),
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: () => addexpense(context),
                child: Text('Add expense'),
              ),
              ElevatedButton(
                onPressed: () => viewexpense(context),
                child: Text('View all expenses'),
              ),
            ],
          )),
    );
  }
}
