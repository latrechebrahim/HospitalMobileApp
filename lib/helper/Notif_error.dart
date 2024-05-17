import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'dart:async';

class NotifContainer extends StatelessWidget {
  const NotifContainer({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String? title;
  final String? content;



  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(
        title ?? '',
        style: TextStyle(
            color: AppTheme.blue, fontSize: 20, fontWeight: FontWeight.normal),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (content != null)
            Padding(
              padding: EdgeInsets.only(bottom: 1),
              child: AnimatedTextKit(animatedTexts: [
                ColorizeAnimatedText(content!,
                    textStyle: GoogleFonts.akshar(
                        fontSize: 20,
                        color: AppTheme.dark,
                        fontStyle: FontStyle.italic
                        ),
                        colors: [
                            AppTheme.blue,
                            AppTheme.dark,
                        ]
                        ),
              ]),
            ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(100, 30)),
              foregroundColor: MaterialStateProperty.all(AppTheme.blue),
              backgroundColor: MaterialStateProperty.all(AppTheme.blue),
            ),
            child: Text(
              "OK",
              style: TextStyle(
                  color: AppTheme.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      shadowColor: Colors.black,
      backgroundColor: AppTheme.white,
      icon: Icon(
        Icons.notifications,
        color: AppTheme.blue,
        size: 30,
      ),
      elevation: 5.0,
    );
  }
}

///////////////////////////////////

void showDelayedAnimatedDialog(
    BuildContext context, String title, String content, Duration delay) {
  Future.delayed(delay, () {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Stack(
            children: [
              Container(
                color: Colors.black.withOpacity(0.6),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.fromDirection(BorderSide.strokeAlignCenter),
                  end: Offset.zero,
                ).animate(animation),
                child: NotifContainer(
                  title: title,
                  content: content,
                ),
              ),
            ],
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  });
}
