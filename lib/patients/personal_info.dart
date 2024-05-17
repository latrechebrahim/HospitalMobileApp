import 'dart:ui';
import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/utils/app_styles.dart';

import '../connection/validation.dart';
import '../helper/Notif_error.dart';
import '../services/dio.dart';
import '../utils/custom_input.dart';

class Page_Personal extends StatefulWidget {
  final Map<String, dynamic> Data;
  const Page_Personal({
    super.key,
    required this.Data,
  });

  @override
  State<Page_Personal> createState() => _Page_PersonalState();
}

class _Page_PersonalState extends State<Page_Personal> {
  Validations validationemail1 = Validations();
  bool? validationfirstname = false;
  bool? validationlastname = false;
  bool? validationphonenumber = false;
  bool? validationemail = false;
  bool _isLoading = false;

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController date_birth = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController imagePath = TextEditingController();

  DioService dioService = DioService();

  Text? ErrorText;
  Icon? suffixIcon;

  Text? ErrorTextvalidatephonenumber;
  Icon? suffixIconvalidatephonenumber;
  Text? ErrorTextvalidationfirstname;
  Icon? suffixIconvalidationfirstname;
  Color? borderColorvalidationfirstname;

  Text? ErrorTextvalidationlastname;
  Icon? suffixIconvalidationlastname;

  @override
  void initState() {
    super.initState();
    phonenumber.text = widget.Data['phonenumber'] ?? 'No Data';
    email.text = widget.Data['email'] ?? 'No Data';
    lastname.text = widget.Data['lastname'] ?? 'No Data';
    firstname.text = widget.Data['firstname'] ?? 'No Data';
    date_birth.text = widget.Data['date_birth'] ?? 'No Data';
    imagePath.text = widget.Data['path'] ?? '';
    _validatelastname(lastname.text);
    _validatefirstname(firstname.text);
    _validateEmail(email.text);
    _validatephonenumber(phonenumber.text);
  }

  void _validatefirstname(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
      Validations().validatefirstname(text);
      ErrorTextvalidationfirstname =
      validationResults['errorText'];
      suffixIconvalidationfirstname =
      validationResults['icon'];
      validationfirstname = validationResults['validation'];
    });
  }
  void _validatelastname(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
      Validations().validatelastname(text);
      ErrorTextvalidationlastname =
      validationResults['errorText'];
      suffixIconvalidationlastname =
      validationResults['icon'];
      validationlastname = validationResults['validation'];
    });
  }
  void _validatephonenumber(String text) {
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
  }
  void _validateEmail(String text) {
    setState(() {
      Map<String, dynamic> validationResults =
      validationemail1.validateEmail(text);
      ErrorText = validationResults['errorText'];
      suffixIcon = validationResults['icon'];
      validationemail = validationResults['validation'];
    });
  }

  @override
  void dispose() {
    phonenumber.dispose();
    email.dispose();
    lastname.dispose();
    firstname.dispose();
    date_birth.dispose();
    super.dispose();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _saveData() {
    if (_validateInputs()) {
      setState(() {
        _isLoading = true;
      });
      dioService.update(
        context,
        widget.Data['id'],
        firstname.text.toString(),
        lastname.text.toString(),
        phonenumber.text.toString(),
        email.text.toString(),
        date_birth.text.toString(),
      );
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved successfully'),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } else {
      // Show validation error
      _showValidationError();
    }
  }

  bool _validateInputs() {

    return  validationemail == true &&
        validationfirstname == true &&
        validationlastname == true &&
        validationphonenumber == true;
  }

  void _showValidationError() {
    // Use the _scaffoldKey to show a SnackBar with the validation error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data saved successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;

    return  SingleChildScrollView(
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 100.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200), // Circular border radius
                            image: DecorationImage(
                              image: imagePath.text.isNotEmpty
                                  ? FileImage(File(imagePath.text as String) as File) as ImageProvider<Object>
                                  : AssetImage('images/person.jpg'),

                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                            MaterialStateProperty.all(Size(100, 40)),
                            foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                            MaterialStateProperty.all(AppTheme.blue.withOpacity(0.4)),
                            mouseCursor:
                            MaterialStateMouseCursor.clickable,
                          ),
                          onPressed: () {
                            // Show dialog to edit user information
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: AppTheme.white,
                                  title: Text('Edit  Information'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            final filePath = await FilePicker.platform.pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: ['jpg', 'jpeg', 'png'],
                                            );
                                            if (filePath != null && filePath.files.isNotEmpty) {
                                              setState(() {
                                                imagePath.text = filePath.files.first.path!;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(200), // Circular border radius
                                              image: DecorationImage(
                                                image: imagePath.text.isNotEmpty
                                                    ? FileImage(File(imagePath.text as String) as File) as ImageProvider<Object>
                                                    : AssetImage('images/person.jpg'),

                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Gap(15),
                                        Container(
                                          width: 330,
                                          height: 100,
                                          child: TextField(
                                            controller: firstname,
                                            keyboardType:
                                            TextInputType.name,
                                            onChanged: (text) {
                                              setState(() {
                                                widget.Data['firstname'] = firstname.text.toString();
                                                Map<String, dynamic>
                                                validationResults =
                                                Validations()
                                                    .validatefirstname(
                                                    text);
                                                ErrorTextvalidationfirstname =
                                                validationResults[
                                                'errorText'];
                                                suffixIconvalidationfirstname =
                                                validationResults[
                                                'icon'];
                                                validationfirstname =
                                                validationResults[
                                                'validation'];
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(30),
                                                  borderSide: BorderSide(
                                                      color:
                                                      AppTheme.blue),
                                                ),
                                                labelText: "Name",
                                                errorText:
                                                ErrorTextvalidationfirstname
                                                    ?.data,
                                                suffix:
                                                suffixIconvalidationfirstname,
                                                icon: Icon(
                                                  Icons.person,
                                                  color: AppTheme.blue,
                                                )),
                                          ),
                                        ),
                                        Container(
                                          width: 330,
                                          height: 100,
                                          child: TextField(
                                            controller: lastname,
                                            keyboardType:
                                            TextInputType.name,
                                            onChanged: (text) {
                                              setState(() {
                                                widget.Data['lastname'] = lastname.text.toString();
                                                Map<String, dynamic>
                                                validationResults =
                                                Validations()
                                                    .validatelastname(
                                                    text);
                                                ErrorTextvalidationlastname =
                                                validationResults[
                                                'errorText'];
                                                suffixIconvalidationlastname =
                                                validationResults[
                                                'icon'];
                                                validationlastname =
                                                validationResults[
                                                'validation'];
                                              }
                                              );
                                            },
                                            decoration: InputDecoration(
                                                border:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        30)),
                                                labelText: "Family_Name",
                                                errorText:
                                                ErrorTextvalidationlastname
                                                    ?.data,
                                                suffix:
                                                suffixIconvalidationlastname,
                                                icon: Icon(
                                                  Icons.person,
                                                  color: AppTheme.blue,
                                                )),
                                          ),
                                        ),
                                        Container(
                                          width: 330,
                                          height: 100,
                                          child: TextField(
                                            readOnly: false,
                                            controller: date_birth,
                                            onTap: () async {
                                              DateTime initialDate = DateTime.now();
                                              if (widget.Data['date_birth'] != null && widget.Data['date_birth'].isNotEmpty) {
                                                try {
                                                  initialDate = DateTime.parse(widget.Data['date_birth']);
                                                } catch (e) {
                                                  print(
                                                      'Error parsing date: $e');
                                                }
                                              }
                                              final selectedDate =
                                              await showDatePicker(
                                                context: context,
                                                initialDate: initialDate,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );

                                              if (selectedDate != null) {
                                                // Update user's date of birth in the widget state
                                                setState(() {
                                                  widget.Data[
                                                  'date_birth'] = formatDate(selectedDate, [
                                                    yyyy,
                                                    '/',
                                                    mm,
                                                    '/',
                                                    dd
                                                  ]).toString();
                                                  date_birth.text = widget.Data['date_birth'];
                                                });
                                              }
                                            },
                                            decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.calendar_month,
                                                color: AppTheme.blue,
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(30)),
                                              labelText: "Date of Birth",
                                              errorText: ErrorText?.data,
                                              suffix: suffixIcon,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 330,
                                          height: 100,
                                          child: TextField(
                                            controller: email,
                                            keyboardType: TextInputType
                                                .emailAddress,
                                            onChanged: (text) {
                                              setState(() {
                                                widget.Data['email'] = email.text.toString();

                                                Map<String, dynamic>
                                                validationResults = validationemail1.validateEmail(text);
                                                ErrorText = validationResults['errorText'];
                                                suffixIcon = validationResults['icon'];
                                                validationemail =
                                                validationResults[
                                                'validation'];
                                              });
                                            },
                                            decoration: InputDecoration(
                                              icon: Icon(
                                                Icons.email,
                                                color: AppTheme.blue,
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(30)),
                                              labelText: "Email Address",
                                              errorText: ErrorText?.data,
                                              suffix: suffixIcon,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 330,
                                          height: 80,
                                          child: TextField(
                                            controller: phonenumber,
                                            keyboardType:
                                            TextInputType.phone,
                                            onChanged: (text) {
                                              setState(() {
                                                widget.Data['phonenumber'] = phonenumber.text.toString();
                                                Map<String, dynamic>
                                                validationResults =
                                                Validations()
                                                    .validatephonenumber(
                                                    text);
                                                ErrorTextvalidatephonenumber =
                                                validationResults[
                                                'errorText'];
                                                suffixIconvalidatephonenumber =
                                                validationResults[
                                                'icon'];
                                                validationphonenumber =
                                                validationResults[
                                                'validation'];

                                              });
                                            },
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(30)),
                                              labelText: 'Phone Number',
                                              errorText:
                                              ErrorTextvalidatephonenumber
                                                  ?.data,
                                              suffix:
                                              suffixIconvalidatephonenumber,
                                              icon: Icon(
                                                Icons.phone,
                                                color: AppTheme.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Add more input fields for other user information
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: _saveData,
                                      child: _isLoading
                                          ? CircularProgressIndicator(
                                        color: AppTheme.blue1,
                                      )
                                          : Text('Save'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Edit'),
                        )
                      ],
                    ),
                    Gap(sh * 0.02 ),
                    Container(
                      width: sw * 0.9,
                      height: sh * 0.72,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[100]?.withOpacity(0.4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.lightBlue.withOpacity(.4),
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Gap(sh * 0.03),
                          CustomOut(
                            sh: sh,
                            sw: sw,
                            labelText: 'Name:',
                            icon: Icons.newspaper_rounded,
                            controller: widget.Data['firstname'] ?? 'No data',
                          ),
                          Gap(sh * 0.01),
                          CustomOut(
                            sh: sh,
                            sw: sw,
                            labelText: 'Family_ Name:',
                            icon: Icons.newspaper_rounded,
                            controller: widget.Data['lastname'] ?? 'No data',
                          ),
                          Gap(sh * 0.03),
                          CustomOut(
                            sh: sh,
                            sw: sw,
                            labelText: 'Date of birth:',
                            icon: Icons.date_range,
                            controller: widget.Data['date_birth'] ?? 'No data',
                          ),
                          Gap(sh * 0.01),
                          CustomOut(
                            sh: sh,
                            sw: sw,
                            labelText: 'Email:',
                            icon: Icons.email,
                            controller: widget.Data['email'] ?? 'No data',
                          ),
                          Gap(sh * 0.01),
                          CustomOut(
                            sh: sh,
                            sw: sw,
                            labelText: 'Phone Number:',
                            icon: AppIcons.phone,
                            controller: widget.Data['phonenumber'] ?? 'No data',
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
