import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:hospital_managements/utils/Cards/slidingCard.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import '../services/dio.dart';
import '../utils/Cards/DoctorsCard.dart';
import 'liste_doctors.dart';
import 'new_appointment.dart';

class Page_Home extends StatefulWidget {
  final Map<String, dynamic> Data;
  const Page_Home({
    super.key,
    required this.Data,
  });

  @override
  State<Page_Home> createState() => _Page_HomeState();
}

class _Page_HomeState extends State<Page_Home> {
  DioService dioService = DioService();
 final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    String path = widget.Data['path']?? 'images/person.jpg';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;
    Map<String, dynamic> data = widget.Data;
    return Padding(
      padding: EdgeInsetsDirectional.all(0),
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: -100.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      width: sw * 1,
                      height: sh * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(100),
                              image: DecorationImage(
                                image: data['path'] != null
                                    ? FileImage(File(data['path'])) as ImageProvider<Object>
                                    : AssetImage('images/person.jpg'),
                                fit: BoxFit.cover,
                              ),

                            ),
                          ),
                          Gap(sw * 0.2),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/02-.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Gap(sw * 0.2),
                          Container(
                            height: sh > 85 ? sh * 0.1 : 85,
                            width: sw > 85 ? sw * 0.1 : 85,
                            child: Icon(
                              Icons.more_vert,
                              color: AppTheme.dark,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      width: sw * 1,
                      height: sh * .08,
                      //color: AppTheme.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedTextKit(animatedTexts: [
                            TypewriterAnimatedText(
                              speed: Durations.short2,
                              'Welcome...',
                              textStyle: GoogleFonts.lobster(
                                fontSize: 20,
                                color: AppTheme.dark,
                              ),
                            ),
                            TypewriterAnimatedText(
                              // speed: Durations.short2,
                              data['firstname'],
                              textStyle: GoogleFonts.lobster(
                                fontSize: 20,
                                color: AppTheme.dark,
                              ),
                            )
                          ]),
                          Text(
                            'How are you feeling today?',
                            style: GoogleFonts.lobster(
                              fontSize: 15,
                              color: AppTheme.blue1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: sh * 0.20,
                      child: FutureBuilder<Map<String, dynamic>>(
                          future: dioService
                              .showAppointments(widget.Data['id'].toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.data == null ||
                                snapshot.data!['appointmentsData'] == null) {
                              return Center(child: Text('No data available'));
                            } else {
                              List<dynamic> appointmentsData =
                                  snapshot.data!['appointmentsData'];
                              return ListWheelScrollViewX(
                                scrollDirection: Axis.horizontal,
                                itemExtent: 350,
                                diameterRatio: 2,
                                clipBehavior: Clip.antiAlias,
                                physics: FixedExtentScrollPhysics(),
                                children: appointmentsData.map((userData) {
                                  Map<String, dynamic> appointment =
                                      userData['appointment'];
                                  Map<String, dynamic> userOriginalData =
                                      userData['userData']['original']
                                          ['userData'];
                                  return SlidingCard(
                                    NameDoctors: 'Dr. ' +
                                            userOriginalData['Doctor']
                                                ?['firstname'] ??
                                        'No data',
                                    date: appointment['date'] ?? 'No data',
                                    title: '',
                                    subtitle: '',
                                    image: userOriginalData['path']?['photo'] ??
                                        'images/person.jpg',
                                    isConfirmead: appointment['confirmed'] == 1,
                                  );
                                }).toList(),
                              );
                            }
                          }),
                    ),
                    Container(
                      height: sh * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("images/Med_Kit.png"),
                            height: 100,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Page_Add_Appointment(Data: data,),
                                    ));
                              },
                              child: Text(
                                "Add new appointment",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppTheme.blue,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: sh * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.white?.withOpacity(0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0),
                            blurRadius: 30,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Nearby doctors',
                                style: TextStyle(
                                  color: AppTheme.blue1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Page_list_doctors(),
                                      ));
                                },
                                child: Text(
                                  'Show All',
                                  style: TextStyle(
                                      color: AppTheme.blue1, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: sh * 0.31,
                            child: FutureBuilder<Map<String, dynamic>>(
                                future: dioService.showDoctors(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else if (snapshot.data == null ||
                                      snapshot.data!['users'] == null) {
                                    return Center(
                                        child: Text('No data available'));
                                  } else {
                                    List<Map<String, dynamic>> Doctors =
                                        List<Map<String, dynamic>>.from(
                                            snapshot.data!['users']);
                                    return Scrollbar(
                                      controller: _scrollController,
                                      radius: Radius.circular(40),
                                      thumbVisibility: true,
                                      child: ListView(
                                        controller: _scrollController,
                                          scrollDirection:
                                          Axis.vertical,
                                          padding:
                                          EdgeInsetsDirectional
                                              .all(10),
                                          clipBehavior:
                                          Clip.antiAlias,
                                          children:
                                          AnimationConfiguration
                                              .toStaggeredList(
                                            duration:
                                            const Duration(
                                                milliseconds:
                                                2000),
                                            childAnimationBuilder:
                                                (widget) =>
                                                SlideAnimation(
                                                  verticalOffset:
                                                  200.0,
                                                  child:
                                                  FadeInAnimation(
                                                    child: widget,
                                                  ),
                                                ),
                                            children: Doctors
                                                .map((Doctor) {
                                              return DoctorsCard(
                                                Name: 'Dr.' + (Doctor['firstname'] ?? 'No Data'),
                                                Phone_number: Doctor['phonenumber'] ?? 'No Data',
                                                photo: Doctor['path'] ?? 'images/person.jpg',
                                                Specialization: Doctor['specialty'] ?? 'No Data',
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                    );
                                  }
                                }),
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
