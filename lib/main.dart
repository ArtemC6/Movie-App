import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:sizer/sizer.dart';

import 'home/cubit/home_cubit.dart';
import 'home/view/home_page.dart';

void main() {
  GetIt.I.registerSingleton<Dio>(Dio());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            platform: TargetPlatform.iOS,
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kPrimaryColor,
          ),
          home: BlocProvider(
            create: (BuildContext context) => HomeCubit()..getMoviesPopular(),
            child: const HomeScreen(),
          ),
        ),
      );
}
