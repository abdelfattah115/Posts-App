import 'package:dartz/dartz.dart';

import '../repository/post_repository.dart';
import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
