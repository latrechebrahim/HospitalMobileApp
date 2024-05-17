import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/connection/validation.dart';
import 'package:hospital_managements/helper/Notif_error.dart';
import 'package:hospital_managements/services/dio.dart';
import '../utils/app_styles.dart';

class SingContainer extends StatefulWidget {
  const SingContainer({
    Key? key,
    required this.sw,
    required this.sh,
  }) : super(key: key);
  final double sh;
  final double sw;

  @override
  _SingContainerState createState() => _SingContainerState();
}

class _SingContainerState extends State<SingContainer> {
  bool _obscureText = true;
  int _currentStep = 1;

  Validations validationemail1 = Validations();

  bool? validationfirstname = false;
  bool? validationlastname = false;
  bool? validationphonenumber = false;
  bool? validationemail = false;
  bool? validationpassword = false;
  bool? validationconfirmpassword = false;

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  Text? ErrorText;
  Icon? suffixIcon;

  Text? ErrorTextpassword;
  Icon? suffixIconpassword;

  Text? ErrorTextconfirmpassword;

  Text? ErrorTextvalidationfirstname;
  Icon? suffixIconvalidationfirstname;
  Color? borderColorvalidationfirstname;

  Text? ErrorTextvalidationlastname;
  Icon? suffixIconvalidationlastname;

  Text? ErrorTextvalidatephonenumber;
  Icon? suffixIconvalidatephonenumber;

  bool _isLoading = false;

  void _back() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _next() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    }
  }

  DioService dioService = DioService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: widget.sh > 85 ? widget.sh * 0.6 : 85,
          width: 380,
          decoration: BoxDecoration(
            //color: AppTheme.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sgin Up",
                  style: GoogleFonts.lobster(
                    fontSize: 30,
                    color: AppTheme.blue,
                  ),
                ),
                SizedBox(height: 10),
                if (_currentStep == 1)
                  Container(
                    width: 330,
                    height: 100,
                    child: TextField(
                      controller: firstname,
                      keyboardType: TextInputType.name,
                      onChanged: (text) {
                        setState(() {
                          Map<String, dynamic> validationResults =
                              Validations().validatefirstname(text);
                          ErrorTextvalidationfirstname =
                              validationResults['errorText'];
                          suffixIconvalidationfirstname =
                              validationResults['icon'];
                          validationfirstname = validationResults['validation'];
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: AppTheme.blue),
                          ),
                          labelText: "First Name",
                          errorText: ErrorTextvalidationfirstname?.data,
                          suffix: suffixIconvalidationfirstname,
                          icon: Icon(
                            Icons.person,
                            color: AppTheme.blue,
                          )),
                    ),
                  ),
                if (_currentStep == 1)
                  Container(
                    width: 330,
                    height: 100,
                    child: TextField(
                      controller: lastname,
                      keyboardType: TextInputType.name,
                      onChanged: (text) {
                        setState(() {
                          Map<String, dynamic> validationResults =
                              Validations().validatelastname(text);
                          ErrorTextvalidationlastname =
                              validationResults['errorText'];
                          suffixIconvalidationlastname =
                              validationResults['icon'];
                          validationlastname = validationResults['validation'];
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          labelText: "Last Name",
                          errorText: ErrorTextvalidationlastname?.data,
                          suffix: suffixIconvalidationlastname,
                          icon: Icon(
                            Icons.person,
                            color: AppTheme.blue,
                          )),
                    ),
                  ),
                if (_currentStep == 2)
                  Container(
                    width: 330,
                    height: 100,
                    child: TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (text) {
                        setState(() {
                          Map<String, dynamic> validationResults =
                              validationemail1.validateEmail(text);
                          ErrorText = validationResults['errorText'];
                          suffixIcon = validationResults['icon'];
                          validationemail = validationResults['validation'];
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: AppTheme.blue,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: "Email Address",
                        errorText: ErrorText?.data,
                        suffix: suffixIcon,
                      ),
                    ),
                  ),
                if (_currentStep == 1)
                  Container(
                    width: 330,
                    height: 80,
                    child: TextField(
                      controller: phonenumber,
                      keyboardType: TextInputType.phone,
                      onChanged: (text) {
                        setState(() {
                          Map<String, dynamic> validationResults =
                              Validations().validatephonenumber(text);
                          ErrorTextvalidatephonenumber =
                              validationResults['errorText'];
                          suffixIconvalidatephonenumber =
                              validationResults['icon'];
                          validationphonenumber =
                              validationResults['validation'];
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: 'Phone Number',
                        errorText: ErrorTextvalidatephonenumber?.data,
                        suffix: suffixIconvalidatephonenumber,
                        icon: Icon(
                          Icons.phone,
                          color: AppTheme.blue,
                        ),
                      ),
                    ),
                  ),
                if (_currentStep == 2)
                  Container(
                    width: 330,
                    height: 100,
                    child: TextField(
                      controller: password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obscureText,
                      onChanged: (text) {
                        setState(() {
                          Map<String, dynamic> validationResults =
                              Validations().validatepassword(text);
                          ErrorTextpassword = validationResults['errorText'];
                          suffixIconpassword = validationResults['icon'];
                          validationpassword = validationResults['validation'];
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: 'Password',
                        icon: Icon(
                          Icons.security,
                          color: AppTheme.blue,
                        ),
                        errorText: ErrorTextpassword?.data,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (_currentStep == 2)
                  Container(
                    width: 330,
                    child: TextField(
                      obscureText: _obscureText,
                      controller: confirmpassword,
                      onChanged: (text) {
                        setState(() {
                          Map<String, dynamic> validationResults = Validations()
                              .validateconfirmpassword(password.text, text);
                          ErrorTextconfirmpassword =
                              validationResults['errorText'];
                          validationconfirmpassword =
                              validationResults['validation'];
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.security,
                          color: AppTheme.blue,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        errorText: ErrorTextconfirmpassword?.data,
                        labelText: 'Confirm Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 30,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  if (_currentStep == 2)
                    ElevatedButton(
                      onPressed: _back,
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(150, 40)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.blue),
                      ),
                      child: Text(
                        "Back",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  SizedBox(
                    width: 10,
                  ),
                  if (_currentStep == 1)
                    ElevatedButton(
                      onPressed: () {
                        if (validationfirstname == true &&
                            validationlastname == true &&
                            validationphonenumber == true) {
                          _next();
                        } else {
                          showDelayedAnimatedDialog(
                              context,
                              "Validation Error",
                              "Please verify your input.",
                              Duration(microseconds: 300));
                        }
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(150, 40)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.blue),
                      ),
                      child:  Text("Next", style: TextStyle(fontSize: 20)),
                    ),
                  if (_currentStep == 2)
                    ElevatedButton(
                        onPressed: () {
                          if (validationemail == true &&
                              validationpassword == true &&
                              validationconfirmpassword == true) {
                            setState(() {
                              _isLoading =
                              true;
                            });
                            dioService.register(
                              context,
                              firstname.text.toString(),
                              lastname.text.toString(),
                              phonenumber.text.toString(),
                              email.text.toString(),
                              password.text.toString(),
                              confirmpassword.text.toString(),
                            );

                          } else {
                            showDelayedAnimatedDialog(
                                context,
                                "Validation Error",
                                "Please verify your input Before Sign up...",
                                Duration(microseconds: 300));

                          }
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(150, 40)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(AppTheme.blue),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: AppTheme.white,
                              )
                            : Text("Sign up", style: TextStyle(fontSize: 20))),
                ]),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
