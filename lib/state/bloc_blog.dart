// lib/bloc/blog_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/blog.dart';
import '../services/api_service.dart';


abstract class BlogEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBlogs extends BlogEvent {}

abstract class BlogState extends Equatable {
  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;

  BlogLoaded(this.blogs);

  @override
  List<Object> get props => [blogs];
}

class BlogError extends BlogState {
  final String message;

  BlogError(this.message);

  @override
  List<Object> get props => [message];
}

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final ApiService apiService;

  BlogBloc(this.apiService) : super(BlogInitial());

  @override
  Stream<BlogState> mapEventToState(BlogEvent event) async* {
    if (event is FetchBlogs) {
      yield BlogLoading();
      try {
        final blogs = await apiService.fetchBlogs();
        yield BlogLoaded(blogs);
      } catch (e) {
        yield BlogError(e.toString());
      }
    }
  }
}
