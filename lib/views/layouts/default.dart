import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: header,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Theme.of(context).primaryColor
          ),
          child: SafeArea(child: body ?? Container())
        )
      ),
    );
  }
}