import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/execptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/post_model.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePost(List<PostModel> posts);
}

const CACHE_POSTS = "CACHE_POSTS";

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePost(List<PostModel> postModels) {
    List postsModelToJson =
        postModels.map((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString(
        CACHE_POSTS, json.encode(postsModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHE_POSTS);
    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodedJsonData
          .map((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    }else {
      throw EmptyCacheException();
    }
  }
}
