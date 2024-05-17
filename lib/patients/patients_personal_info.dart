import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/patients/hospital_info.dart';
import 'package:hospital_managements/patients/notification.dart';
import 'package:hospital_managements/patients/personal_info.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:provider/provider.dart';
import '../Connection/connection.dart';
import '../services/auth.dart';
import '../utils/Cards/slidingCard.dart';
import '../utils/text_edit.veiw.dart';
import 'home.dart';

class PatientsPersonalInfo extends StatefulWidget {
  final Map<String, dynamic> Data;

  PatientsPersonalInfo({Key? key, required this.Data}) : super(key: key);

  @override
  State<PatientsPersonalInfo> createState() => _PatientsPersonalInfoState();
}

class _PatientsPersonalInfoState extends State<PatientsPersonalInfo>
    with SingleTickerProviderStateMixin {
  var currentIndex = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [

      Page_Home(Data: widget.Data),
      Page_Hospital(),
      Page_Personal(Data: widget.Data,),
      Page_Notification(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;
    return Scaffold(
      body: SizedBox.expand(
        child: Consumer<Auth>(builder: (context, auth, child) {
          if (auth.authentcated) {
            return Container(
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
              child: Column(
                children: [
                  SizedBox(height: sh * 0.02),
                  Expanded(
                    child: pages[currentIndex],
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: sh * 0.063,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 30,
                          offset: Offset(0, 10),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.024),
                      itemBuilder: (context, index) =>
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 3000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  margin: EdgeInsets.only(
                                    bottom: index == currentIndex ? 0 : sw *
                                        0.029,
                                    right: sw * 0.0422,
                                    left: sw * 0.0422,
                                  ),
                                  width: sw * 0.128,
                                  height: index == currentIndex
                                      ? sw * 0.014
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10),
                                    ),
                                  ),
                                ),
                                Icon(
                                  ListOfIcons[index],
                                  size: sw * 0.076,
                                  color: index == currentIndex
                                      ? Colors.blueAccent
                                      : Colors.black38,
                                ),
                                SizedBox(height: sw * 0.03),
                              ],
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            );
          }
          return ConnectionLogin();
        }
          ),
      ),
    );
  }

  List<IconData> ListOfIcons = [
    Icons.home_rounded,
    Icons.medical_information,
    Icons.perm_contact_cal,
    Icons.notifications_active_outlined,
  ];
}
