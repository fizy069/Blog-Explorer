import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/blog.dart';
import '../services/api_service.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

  BlogError({this.message = 'Something went wrong. Please try again.'});

  @override
  List<Object> get props => [message];
}

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final ApiService apiService;
  final Box<Blog> blogBox;

  BlogBloc(this.apiService, this.blogBox) : super(BlogInitial()) {
    on<FetchBlogs>(_onFetchBlogs);
  }

  void _onFetchBlogs(FetchBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());

    
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
     
      final cachedBlogs = blogBox.values.toList();
      if (cachedBlogs.isNotEmpty) {
        emit(BlogLoaded(cachedBlogs));
      } else {
        emit(BlogError());
      }
      return;
    }

    try {
      final blogs = await apiService.fetchBlogs();
      emit(BlogLoaded(blogs));

      for (var blog in blogs) {
        blogBox.put(blog.id, blog); 
      }
    } catch (e) {
      final cachedBlogs = blogBox.values.toList();
      if (cachedBlogs.isNotEmpty) {
        emit(BlogLoaded(cachedBlogs));
      } else {
        emit(BlogError());
      }
    }
  }
}
