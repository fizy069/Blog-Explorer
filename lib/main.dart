// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state/bloc_blog.dart';
import 'services/api_service.dart';
import 'views/home.dart';

void main() {
  runApp(BlogExplorerApp());
}

class BlogExplorerApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  BlogExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => BlogBloc(apiService)..add(FetchBlogs()),
        child: Home(),
      ),
    );
  }
}
