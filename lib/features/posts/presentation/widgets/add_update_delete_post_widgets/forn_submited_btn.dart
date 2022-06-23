import 'package:flutter/material.dart';

class FormSubmittedBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatedPost;

  const FormSubmittedBtn(
      {Key? key, required this.onPressed, required this.isUpdatedPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: isUpdatedPost ? const Icon(Icons.edit) : const Icon(Icons.add),
      label: Text(isUpdatedPost ? 'Update' : 'Add'),
    );
  }
}
