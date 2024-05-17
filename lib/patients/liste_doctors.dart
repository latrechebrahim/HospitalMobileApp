import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import '../services/dio.dart';
import '../utils/Cards/DoctorsCard.dart';
import '../utils/text_edit.veiw.dart';

class Page_list_doctors extends StatefulWidget {
  const Page_list_doctors({
    super.key,
  });

  @override
  State<Page_list_doctors> createState() => _Page_list_doctorsState();
}

class _Page_list_doctorsState extends State<Page_list_doctors> {
  DioService dioService = DioService();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.blue,
        title: Text(
          'All Doctors',
          style: TextStyle(
              color: AppTheme.white, fontSize: 25, fontWeight: FontWeight.w900),
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          height: sh,
          width: sw,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFF3B7BC7),
              ],
            ),
          ),
          child: SingleChildScrollView(
              child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                  children: [
                    Container(
                      height: sh * 1,
                      child: Column(children: [
                        Gap(10),
                        Container(
                          width: sw * 1,
                          height: sh * 0.1,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                width: sw * 1,
                                child: TextEditView(
                                  hint: "Doctors...",
                                  suffixIcon: Icons.search,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
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
                      ]),
                    )
                  ]),
            ),
          )),
        ),
      ),
    );
  }
}
