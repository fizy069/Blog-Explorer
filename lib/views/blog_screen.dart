import 'package:flutter/material.dart';
import '../models/blog.dart';

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;

  BlogDetailScreen({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: blog.imageUrl,
              child: Image.network(
                blog.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[900],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Published on 08/08/2024', 
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vehicula orci nec urna vehicula, nec dignissim justo viverra. Nullam interdum, est nec aliquet varius, nunc ipsum lacinia arcu, at fermentum velit ligula eget lorem. Donec nec turpis sed erat ullamcorper sollicitudin non sit amet lacus. Vivamus eu quam at nulla euismod fermentum non id ligula. Aenean auctor, justo in malesuada auctor, nisi erat placerat lorem, id lobortis eros felis in turpis. Curabitur tincidunt mauris et sem varius, id congue tortor vehicula.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Suspendisse potenti. Morbi non dui eget metus aliquet tincidunt. Pellentesque at vestibulum velit. Fusce ac nisi non justo lacinia efficitur. Aliquam erat volutpat. Nullam eu massa arcu. Etiam pharetra eros a velit dictum, ut dignissim neque tincidunt. Cras interdum lacus at tortor condimentum tincidunt.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100], // Background color added here
    );
  }
}
