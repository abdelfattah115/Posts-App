import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_update_delete_posts/add_update_delete_posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/widgets/add_update_delete_post_widgets/forn_submited_btn.dart';

import 'text_form_field_widget.dart';

class FormPostWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdatePost;

  const FormPostWidget({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  State<FormPostWidget> createState() => _FormPostWidgetState();
}

class _FormPostWidgetState extends State<FormPostWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
              multiLines: false, name: 'Title', controller: _titleController),
          TextFormFieldWidget(
              multiLines: true, name: 'Body', controller: _bodyController),
          FormSubmittedBtn(
              onPressed: _validateFormThenUpdateOrAddPost,
              isUpdatedPost: widget.isUpdatePost),
        ],
      ),
    );
  }

  _validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );
      if (widget.isUpdatePost) {
        BlocProvider.of<AddUpdateDeletePostsBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddUpdateDeletePostsBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
