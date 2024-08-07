// lib/screens/blog_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/bloc_blog.dart';
import '../models/blog.dart';
import '../views/blog_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Explorer'),
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BlogLoaded) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return ListTile(
                  leading: Image.network(blog.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(blog.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailScreen(blog: blog),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is BlogError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Press the button to fetch blogs'));
        },
      ),
    );
  }
}
