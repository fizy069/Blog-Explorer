import 'dart:convert';
import 'package:blog_explorer/secrets/auth_secrets.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  

  Future<List<Blog>> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': AuthSecrets.adminSecret,
      });

      if (response.statusCode == 200) {
        //neeed to convert the response body to a List of blogs
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
