import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final PreferredSizeWidget? header;
  final Widget? body;
  final Color? backgroundColor;

  const DefaultLayout({this.header, this.body, this.backgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: header,
          body: body
        )
      ),
    );
  }
}