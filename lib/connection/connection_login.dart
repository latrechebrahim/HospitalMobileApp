import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/connection/validation.dart';
import 'package:hospital_managements/helper/Notif_error.dart';
import 'package:hospital_managements/services/dio.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:hospital_managements/utils/custom_input.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../patients/patients_personal_info.dart';
import '../services/auth.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({
    Key? key,
    required this.sh,
    required this.sw,
  }) : super(key: key);

  final double sh;
  final double sw;

  @override
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  int _currentStep = 1;

  DioService dioService = DioService();

  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();

  Validations validationemail = Validations();

  Text? ErrorText;
  Icon? suffixIcon;

  Text? ErrorTextpassword;
  Icon? suffixIconpassword;

  bool selected = false;

  bool _isLoading = false;
  void _LoginWithePhone() {
    setState(() {
      _currentStep = 2;
    });
  }

  void _LoginWitheEmail() {
    setState(() {
      _currentStep = 1;
    });
  }

  void _forgetPassword() {
    setState(() {
      _currentStep = 3;
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 1000),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: _currentStep == 1
            ? Container(
                key: ValueKey<int>(1),
                child: LoginUsingEmail(context),
              )
            : Container(
                    key: ValueKey<int>(3),
                    child: ForgetPassword(context, selected),
                  ),
      ),
    );
  }

  Container LoginUsingEmail(BuildContext context) {
    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: widget.sh > 85 ? widget.sh * 0.6 : 85,
          width: 380,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Login",
                style: GoogleFonts.lobster(
                  fontSize: 30,
                  color: AppTheme.blue,
                ),
              ),
              SizedBox(height: 20),
              CustomInputContainer(
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email Address ',
                controller: email,
                icon: Icon(
                  FontAwesomeIcons.envelope,
                  color: AppTheme.blue,
                ),
              ),
              CustomInputPassword(
                labelText: 'Password',
                controller: password,
                icon: Icon(
                  Icons.security,
                  color: AppTheme.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 50, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if ((_currentStep == 1) || (_currentStep == 2))
                      InkWell(
                        onTap: _forgetPassword,
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading =
                        true; // Set isLoading to true when button is pressed
                  });
                  Future<Map<String, dynamic>> response = dioService.login(
                    email.text.toString(),
                    password.text.toString(),
                    context,
                  );
                  response.then((value) {
                    setState(() {
                      _isLoading = false;
                    });
                    if (value['status'] == 200) {
                      Map<String, dynamic> userData = value['user'];
                      Provider.of<Auth>(context, listen: false).login(userData);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PatientsPersonalInfo(Data: userData,),
                          ),
                        );
                    }
                    else
                    if (value['status'] == 400) {
                      showDelayedAnimatedDialog(
                        context,
                        'errer',
                        value['message'],
                        Duration(microseconds: 1000),
                      );
                    }
                    else
                    if (value['status'] == 401) {
                      showDelayedAnimatedDialog(
                        context,
                        'message',
                        value['message'],
                        Duration(microseconds: 1000),
                      );
                    }
                    else
                    if (value['status'] == 402) {
                      showDelayedAnimatedDialog(
                        context,
                        'message',
                        value['message'],
                        Duration(microseconds: 1000),
                      );
                    }
                  });
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(150, 40)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(AppTheme.blue),
                  mouseCursor: MaterialStateMouseCursor.clickable,
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: AppTheme.white,
                      )
                    : Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  Container ForgetPassword(BuildContext context, bool selected) {
    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: widget.sh > 85 ? widget.sh * 0.6 : 85,
          width: 380,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                "Login",
                style: GoogleFonts.lobster(
                  fontSize: 30,
                  color: AppTheme.blue,
                ),
              ),
              SizedBox(height: 40),
              CustomInputContainer(
                keyboardType: TextInputType.phone,
                labelText: ' Phone Number',
                controller: phonenumber,
                icon: Icon(
                  FontAwesomeIcons.envelope,
                  color: AppTheme.blue,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Future<Map<String, dynamic>> response = dioService.login(
                      email.text.toString(),
                      password.text.toString(),
                      context,
                  );
                  response.then((value) {
                    if (value['status'] == 200) {
                      showDelayedAnimatedDialog(context, value['message1'],
                          value['message2'], Duration(microseconds: 300));
                       MaterialPageRoute(builder: (BuildContext context) => PatientsPersonalInfo(Data: value['user'],),);
                    }
                    if (value['status'] == 401) {
                      showDelayedAnimatedDialog(context, value['message'],
                          value['error'], Duration(microseconds: 300));
                    }
                    if (value['status'] == 402) {
                      showDelayedAnimatedDialog(context, value['message'],
                          value['error'], Duration(microseconds: 300));
                    }
                  });
                },
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(150, 40)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(AppTheme.blue),
                    mouseCursor: MaterialStateMouseCursor.clickable),
                child: Text("sand",
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 50, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Back to Login ',
                          ),
                          InkWell(
                            onTap: _LoginWitheEmail,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: AppTheme.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
