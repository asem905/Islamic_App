import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quaran_app/cubit/hadiths_cubit.dart';
import 'package:quaran_app/cubit/quaran_cubit.dart';
import 'package:quaran_app/home.dart';
import 'package:quaran_app/view/viewall_surah.dart';
import 'package:quaran_app/view/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuaranCubit(),
        ),
        BlocProvider(
          create: (context) => HadithsCubit(),
        ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => WelcomeScreen(),
        '/home': (context) => HomePage(),
        '/surahsList':(context) => const ViewallSurahs(),
      },
      initialRoute: '/',
    )
    );
  }
}

