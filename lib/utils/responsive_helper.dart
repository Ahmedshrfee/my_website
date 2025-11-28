import 'package:flutter/material.dart';

class ResponsiveHelper extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet; // التابلت اختياري، إذا لم يوجد نعرض الجوال
  final Widget desktop;

  const ResponsiveHelper({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  // تعريف نقاط التحول (Breakpoints)
  static bool isMobile(BuildContext context) =>
      MediaQuery
          .of(context)
          .size
          .width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery
          .of(context)
          .size
          .width >= 650 && MediaQuery
          .of(context)
          .size
          .width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery
          .of(context)
          .size
          .width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth >= 650) {
          // إذا تم تمرير ويدجت للتابلت نعرضه، وإلا نعرض الجوال
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}