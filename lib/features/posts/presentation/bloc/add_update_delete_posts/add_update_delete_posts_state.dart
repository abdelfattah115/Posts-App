part of 'add_update_delete_posts_bloc.dart';

@immutable
abstract class AddUpdateDeletePostsState extends Equatable {
  const AddUpdateDeletePostsState();

  @override
  List<Object?> get props => [];
}

class AddUpdateDeletePostsInitial extends AddUpdateDeletePostsState {}

class LoadingAddUpdateDeletePosts extends AddUpdateDeletePostsState {}

class SuccessAddUpdateDeletePosts extends AddUpdateDeletePostsState {
  final String message;

  const SuccessAddUpdateDeletePosts({required this.message});

  @override
  List<Object?> get props => [message];
}

class ErrorAddUpdateDeletePosts extends AddUpdateDeletePostsState {
  final String message;

  const ErrorAddUpdateDeletePosts({required this.message});

  @override
  List<Object?> get props => [message];
}
