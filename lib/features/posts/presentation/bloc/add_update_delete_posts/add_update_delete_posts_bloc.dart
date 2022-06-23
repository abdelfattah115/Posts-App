// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/post.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/failure.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'add_update_delete_posts_event.dart';

part 'add_update_delete_posts_state.dart';

class AddUpdateDeletePostsBloc
    extends Bloc<AddUpdateDeletePostsEvent, AddUpdateDeletePostsState> {
  final AddPostUseCase addPost;
  final UpdatePostsUseCase updatePost;
  final DeletePostUseCase deletePost;

  AddUpdateDeletePostsBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(AddUpdateDeletePostsInitial()) {
    on<AddUpdateDeletePostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeletePosts());
        final failureOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddUpdateDeletePosts());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddUpdateDeletePosts());
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddUpdateDeletePostsState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) =>
            ErrorAddUpdateDeletePosts(message: _mapErrorMessage(failure)),
        (_) => SuccessAddUpdateDeletePosts(message: message));
  }

  String _mapErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return DEFUALT_FAILURE_MESSAGE;
    }
  }
}
