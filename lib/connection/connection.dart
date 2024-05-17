import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hospital_managements/connection/connection_login.dart';

import '../utils/app_styles.dart';
import 'package:animations/animations.dart';

import 'connection_registration.dart';

class ConnectionLogin extends StatefulWidget {
  const ConnectionLogin({super.key});
  @override
  State<ConnectionLogin> createState() => _ConnectionLoginState();
}

class _ConnectionLoginState extends State<ConnectionLogin> {
  bool _onLogin = true;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: sh,
          width: sw,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xFFFFFFFF),
                Color(0xFF0B50A4),
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 500),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: -50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                SizedBox(height: sh * 0.03),
                Image.asset(
                  "images/02-.png",
                  height: 120,
                  width: 120,
                ),
                SizedBox(
                  height: sh * 0.02,
                ),
                AnimatedTextKit(animatedTexts: [
                  TyperAnimatedText("Welcom... ",
                      textStyle: GoogleFonts.lobster(
                        fontSize: 30,
                        color: AppTheme.blue,
                      )),
                ]),
                SizedBox(
                  height: sh * 0.03,
                ),
                PageTransitionSwitcher(
                  duration: Duration(milliseconds: 2000),
                  reverse: !_onLogin,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: SharedAxisTransition(
                        child: child,
                        animation: animation,
                        secondaryAnimation: kAlwaysDismissedAnimation,
                        transitionType: SharedAxisTransitionType.scaled,
                      ),
                    );
                  },
                  child: _onLogin
                      ? LoginContainer(
                          sh: sh,
                          sw: sw,
                        )
                      : SingContainer(
                          sw: sw,
                          sh: sh,
                        ),
                ),
                SizedBox(
                  height: sh * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _onLogin = !_onLogin;
                        });
                      },
                      child: _onLogin
                          ? Text(
                              "Don't have an account? Sing Up",
                              style: TextStyle(
                                  color: AppTheme.white,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "I have an account? Login",
                              style: TextStyle(
                                  color: AppTheme.white,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
