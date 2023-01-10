import 'package:flutter/material.dart';
import 'package:testmobile_flutter/sql_helper.dart';
import 'package:testmobile_flutter/test1/onboard/onboard_screen.dart';


final dbHelper = SQLHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  await dbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnBoardScreen(),
    );
  }
}

