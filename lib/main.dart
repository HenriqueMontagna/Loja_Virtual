import 'package:flutter/material.dart';
import 'package:loja_online2/models/user_model.dart';
import 'package:loja_online2/screens/home_screen.dart';
import 'package:loja_online2/screens/login_screen.dart';
import 'package:loja_online2/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}