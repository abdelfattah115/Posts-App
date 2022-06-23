import 'package:dartz/dartz.dart';

import '../repository/post_repository.dart';
import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class AddPostUseCase {
  final PostRepository repository;

  AddPostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
