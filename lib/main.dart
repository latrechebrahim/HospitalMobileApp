
import 'package:flutter/material.dart';
import 'package:hospital_managements/Connection/connection.dart';
import 'package:hospital_managements/patients/patients_personal_info.dart';
import 'package:hospital_managements/services/auth.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnectionLogin(),
    );
  }
}

void main() {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child:  MyApp(),
    ),
  );
}