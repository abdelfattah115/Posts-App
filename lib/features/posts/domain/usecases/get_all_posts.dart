import 'package:dartz/dartz.dart';

import '../repository/post_repository.dart';
import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class GetAllPostsUseCase {
  final PostRepository repository;

  GetAllPostsUseCase({required this.repository});

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
