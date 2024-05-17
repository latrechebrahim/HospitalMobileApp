import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_styles.dart';

class CustomInputContainer extends StatefulWidget {
  const CustomInputContainer({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.icon,
    required this.keyboardType,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final Icon icon;
  final TextInputType keyboardType;

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInputContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 100,
      child: TextField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
            labelText: widget.labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            icon: widget.icon),
      ),
    );
  }
}

class CustomInputPassword extends StatefulWidget {
  const CustomInputPassword({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final Icon icon;

  @override
  _CustomInputPasswordState createState() => _CustomInputPasswordState();
}

class _CustomInputPasswordState extends State<CustomInputPassword> {
   bool _obscureText = true;
  @override
  Widget build(BuildContext context) {


    return Container(
      width: 330,
      height: 100,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          icon: widget.icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
              size: 17,
            ),
          ),
        ),
        obscureText: _obscureText,
      ),
    );
  }
}


class CustomOut extends StatefulWidget {
  const CustomOut({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.icon,
    required this.sh,
    required this.sw,
  }) : super(key: key);

  final String labelText;
  final String controller;
  final IconData icon;
  final double sh;
  final double sw;

  @override
  _CustomOutState createState() => _CustomOutState();
}

class _CustomOutState extends State<CustomOut> {

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: widget.sh * 0.12,
        width: widget.sw * .8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(widget.sw * 0.01),
                Container(
                  width: widget.sw * 0.12,
                  height: widget.sh * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.white?.withOpacity(0.4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightBlueAccent.withOpacity(.7),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    widget.icon,
                    color: AppTheme.blue1,
                    size: 30,
                  ),
                ),
                Gap(widget.sw * 0.01),
                Container(
                  height: widget.sh * 0.05,
                 width: widget.sw * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white?.withOpacity(0.4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightBlue.withOpacity(.3),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(widget.sw * 0.02),
                      Text(
                        widget.labelText,
                        style: TextStyle(
                          color: AppTheme.blue1,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(widget.sw * 0.01),
                    ],
                  ),
                ),
              ],
            ),
            Gap(widget.sh * 0.01),
            Container(
              height: widget.sh * 0.06,
              width: widget.sw * 0.65,
              decoration: BoxDecoration(
                color: Colors.white?.withOpacity(0.4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlue.withOpacity(.3),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(widget.sw * 0.02),
                  Text(
                    widget.controller,
                    style: GoogleFonts.labrada(
                      fontSize: 16,
                      color: AppTheme.dark,
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}


