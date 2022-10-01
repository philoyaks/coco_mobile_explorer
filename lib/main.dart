import 'package:coco_mobile_explorer/features/search/data/datasources/search_service.dart';
import 'package:coco_mobile_explorer/features/search/data/repositories/search_repo_implementation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/search/presentation/bloc/search_bloc.dart';
import 'features/search/presentation/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchBloc(SearchService(SearchRepositoryImplementation())),
      child: MaterialApp(
        title: 'Coco Mobile App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
