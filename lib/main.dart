import 'package:flutter/material.dart';
import 'package:food/config/constants/size_config.dart';
import 'package:food/presentation/screens/screens.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.orange),
      ),
      home: const HomeScreen(),
    );
  }
}
