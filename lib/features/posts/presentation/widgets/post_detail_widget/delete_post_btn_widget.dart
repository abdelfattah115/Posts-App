import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';

import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/snack_bar_message.dart';
import '../../bloc/add_update_delete_posts/add_update_delete_posts_bloc.dart';
import '../../pages/posts_page.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.redAccent),
      ),
      onPressed: () => deleteShowDialog(context),
      icon: const Icon(Icons.delete_outline),
      label: const Text('Delete'),
    );
  }
  void deleteShowDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddUpdateDeletePostsBloc,
              AddUpdateDeletePostsState>(
            builder: (context, state) {
              if (state is LoadingAddUpdateDeletePosts) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              } else {
                return DeleteDialogWidget(postId: postId);
              }
            },
            listener: (context, state) {
              if (state is SuccessAddUpdateDeletePosts) {
                SnackBarMessage().successSnackBar(context, state.message);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                        (route) => false);
              } else if (state is ErrorAddUpdateDeletePosts) {
                SnackBarMessage().errorSnackBar(context, state.message);
                Navigator.of(context).pop();
              }
            },
          );
        });
  }
}
