import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/posts_widgets/error_message_widget.dart';
import '../widgets/posts_widgets/posts_list_widget.dart';
import 'add_update_post_page.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
        ),
      ),
      body: _bodyWidget(context),
      floatingActionButton: _floatingActionButtonWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is SuccessPostsState) {
            return RefreshIndicator(
              onRefresh: () => _onRefreshPosts(context),
              child: PostsListWidget(
                posts: state.posts,
              ),
            );
          } else if (state is ErrorPostsState) {
            return const ErrorMessageWidget();
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }

  Future<void> _onRefreshPosts(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  _floatingActionButtonWidget(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddUpdatePostPage(
              isUpdatePost: false,
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
