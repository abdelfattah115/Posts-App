import 'package:flutter/material.dart';
import 'package:posts_app/core/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:  SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(color: secondaryColor,),
      ),
    );
  }
}
