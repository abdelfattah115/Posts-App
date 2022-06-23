import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final bool multiLines;
  const TextFormFieldWidget({Key? key, required this.controller, required this.name, required this.multiLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        decoration:  InputDecoration(hintText: name),
        maxLines: multiLines? 6: 1,
        minLines: multiLines? 6: 1,
        validator: (val) => val!.isEmpty? '$name must not be empty...': null,
      ),
    );
  }
}
