import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultLayout extends StatelessWidget {
  final PreferredSizeWidget? header;
  final Widget? body;
  final Color? backgroundColor;
  final String? backgroundImage;

  const DefaultLayout({this.header, this.body, this.backgroundColor, this.backgroundImage, super.key});

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
          child: SafeArea(
            child: Container(
              decoration: backgroundImage != null
                ? BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.9,
                    image: AssetImage(backgroundImage!),
                    fit: BoxFit.cover
                  )
                )
                : null,
                child: body
            )
          )
        )
      ),
    );
  }
}