import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:hospital_managements/utils/Cards/slidingCard.dart';
import 'package:hospital_managements/utils/text_edit.veiw.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';

import '../utils/custom_input.dart';

class Page_Hospital extends StatefulWidget {
  const Page_Hospital({
    super.key,
  });

  @override
  State<Page_Hospital> createState() => _Page_HospitalState();
}

class _Page_HospitalState extends State<Page_Hospital> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;
    return SingleChildScrollView(
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: -100.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Container(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Column(
                    children: [
                      Container(
                        width: sw,
                        height: sh * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: sh * 0.2,
                              width: sw * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/02-.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(sh * 0.08),
                      Container(
                        width: sw * 0.9,
                        height: sh * 0.65,
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
                            Gap(sh * 0.04),
                            Container(
                              height: sh * 0.06,
                              width: sw * 1,
                              decoration: BoxDecoration(
                                color: Colors.white?.withOpacity(0.4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.lightBlue.withOpacity(.4),
                                    blurRadius: 30,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Gap(sw * 0.08),
                                  Text(
                                    'Hospital Name:',
                                    style: TextStyle(
                                      color: AppTheme.blue1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Gap(sw * 0.03),
                                  Text(
                                    'Hospital',
                                    style: GoogleFonts.labrada(
                                      fontSize: 20,
                                      color: AppTheme.dark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(sh * 0.01),
                            CustomOut(
                              sh: sh,
                              sw: sw,
                              labelText: 'Location:',
                              icon: Icons.location_on,
                              controller: 'data',
                            ),
                            Gap(sh * 0.01),
                            CustomOut(
                              sh: sh,
                              sw: sw,
                              labelText: 'Phone Number:',
                              icon: AppIcons.phone,
                              controller: '0652585585',
                            ),
                            Gap(sh * 0.01),
                            CustomOut(
                              sh: sh,
                              sw: sw,
                              labelText: 'The Website:',
                              icon: BoxIcons.bxl_chrome,
                              controller: 'www.hospital.com',
                            ),
                            Gap(sh * 0.01),
                            CustomOut(
                              sh: sh,
                              sw: sw,
                              labelText: 'Hospital Email:',
                              icon: Icons.email,
                              controller: 'hospital@gmail.com',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
