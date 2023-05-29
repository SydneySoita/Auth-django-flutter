import 'package:flutter/material.dart';

import 'login.dart';

class HomepageScreen extends StatelessWidget {
  void loginUser(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage')),
      body: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () => loginUser(context),
          child: Text('Login'),
        ),
      ),
    );
  }
}
