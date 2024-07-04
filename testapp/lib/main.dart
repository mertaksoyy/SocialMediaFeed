import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/ui/cubit/mainpage_cubit.dart';
import 'package:testapp/ui/cubit/postcreatepage_cubit.dart';
import 'package:testapp/ui/cubit/postdetailpage_cubit.dart';

import 'package:testapp/ui/view/mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PostCreateCubit()),
        BlocProvider(create: (context) => PostDetailCubit()),
        BlocProvider(create: (context) => MainPageCubit())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MainPage()),
    );
  }
}
