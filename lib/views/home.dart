import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../state/bloc_blog.dart';
import 'blog_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: const Text('Subspace : Blog Explorer', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BlogLoaded) {
            if (state.blogs.isEmpty) {
              return _buildEmptyState();
            }
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(blog.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    leading: _buildImage(blog.imageUrl), 
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(blog: blog),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is BlogError) {
            return _buildErrorState(state.message);
          }
          return const Center(child: Text('Press the button to fetch blogs'));
        },
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
  return FutureBuilder<bool>(
    future: _checkConnectivity(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(), 
        );
      }
      if (snapshot.hasData && snapshot.data == false) {
        return Image.asset('assets/placeholder.jpg', width: 50, height: 50); 
      }
      return Image.network(
        imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/placeholder.jpg', width: 50, height: 50);
        },
      );
    },
  );
}


  Future<bool> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none; 
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.article, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No Blogs Available',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Please check back later.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Please try again later.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
