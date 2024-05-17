import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_managements/utils/app_styles.dart';
import 'package:hospital_managements/utils/Cards/slidingCard.dart';
import 'package:hospital_managements/utils/text_edit.veiw.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';

import '../utils/Cards/CardNotifcation.dart';

class Page_Notification extends StatefulWidget {
  const Page_Notification({
    super.key,
  });

  @override
  State<Page_Notification> createState() => _Page_NotificationState();
}

class _Page_NotificationState extends State<Page_Notification> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sh = screenSize.height;
    double sw = screenSize.width;

    List<Map<String, dynamic>> notifications = [
      {
        "name": "John Doe",
        "date": "October 25, 2023",
        "photo": "images/person.jpg",
        "isRead": false,
      },
      {
        "name": "Jane Smith",
        "date": "October 26, 2023",
        "photo": "images/person.jpg",
        "isRead": true,
      },
      {
        "name": "Alice Johnson",
        "date": "October 27, 2023",
        "photo": "images/person.jpg",
        "isRead": true,
      },
    ];

    return SingleChildScrollView(
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
                height: sh * 0.85,
                child: Column(children: [
                  Container(
                    width: sw * 1,
                    height: sh * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Notification',
                          style: TextStyle(
                              color: AppTheme.blue1,
                              fontSize: 25,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: CardNotifcation(
                              notifications: notifications, index: index),
                        );
                      },
                    ),
                  ),
                ]),
              )
            ]),
      ),
    ));
  }
}
