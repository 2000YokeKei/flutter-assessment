import 'package:flutter/material.dart';
import 'package:flutter_assesment/Bloc/activity_cubit.dart';
import 'package:flutter_assesment/view/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => ActivityCubit(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Random Activity Finder'),
    );
  }
}

