import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/api_service.dart'; 
import 'state/bloc_blog.dart'; 
import 'models/blog.dart'; 
import 'views/home.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BlogAdapter());
  await Hive.openBox<Blog>('blogBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService(); 
  final Box<Blog> blogBox = Hive.box<Blog>('blogBox'); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Explorer',
      home: BlocProvider(
        create: (context) => BlogBloc(apiService, blogBox)..add(FetchBlogs()),
        child: Home(),
      ),
    );
  }
}
