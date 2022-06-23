import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/widgets/snack_bar_message.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_update_delete_posts/add_update_delete_posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/pages/posts_page.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/post.dart';
import '../widgets/add_update_delete_post_widgets/form_post_widget.dart';

class AddUpdatePostPage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const AddUpdatePostPage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child:
        BlocConsumer<AddUpdateDeletePostsBloc, AddUpdateDeletePostsState>(
          builder: (context, state) {
            if (state is LoadingAddUpdateDeletePosts) {
              return const LoadingWidget();
            } else {
              return FormPostWidget(
                isUpdatePost: isUpdatePost,
                post: isUpdatePost ? post : null,
              );
            }
          },
          listener: (context, state) {
            if (state is SuccessAddUpdateDeletePosts) {
              SnackBarMessage().successSnackBar(context, state.message);
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) => const PostsPage(),), (
                      route) => false);
            } else if (state is ErrorAddUpdateDeletePosts) {
              SnackBarMessage().errorSnackBar(context, state.message);
            }
          },
        ),
      ),
    );
  }
}
