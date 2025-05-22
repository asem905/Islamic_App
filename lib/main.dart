import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quaran_app/controller/cubit/athkar_cubit.dart';
import 'package:quaran_app/controller/cubit/hadiths_cubit.dart';
import 'package:quaran_app/controller/cubit/prayertimes_cubit.dart';
import 'package:quaran_app/controller/cubit/qibla_cubit.dart';
import 'package:quaran_app/controller/cubit/quaran_cubit.dart';
import 'package:quaran_app/controller/cubit/tafseer_cubit.dart';

import 'package:quaran_app/home.dart';
import 'package:quaran_app/view/prayertimes/qibla_page.dart';
import 'package:quaran_app/view/quaran/viewall_surah.dart';
import 'package:quaran_app/view/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences sharedPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
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
          create: (context) => PrayertimesCubit(),
        ),
        BlocProvider(create: (context) => AthkarCubit()),
        BlocProvider(
          create: (context) => QuaranCubit(),
        ),
        BlocProvider(
          create: (context) => HadithsCubit(),
        ),
        BlocProvider(
          create: (context) => QiblaCubit(),
        ),
        BlocProvider(
          create: (context) => TafseerCubit(),
        ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => WelcomeScreen(),
        '/home': (context) => HomePage(),
        '/surahsList':(context) => const ViewallSurahs(),
        '/qibla':(context) => const QiblaDirectionPage(),
      },
      initialRoute: '/',
    )
    );
  }
}

