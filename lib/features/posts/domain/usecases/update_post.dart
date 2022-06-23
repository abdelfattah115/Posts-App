import 'package:dartz/dartz.dart';

import '../repository/post_repository.dart';
import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class UpdatePostsUseCase{
  final PostRepository repository;

  UpdatePostsUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
