import 'package:flutter/material.dart';
import 'package:get/get.dart';

class navigationController extends GetxController {
  // ================== مفاتيح الأقسام (Scroll Keys) ==================
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey certificatesKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  // ================== حالة القائمة (Menu State) ==================
  var isMenuOpen = false.obs;

  void toggleMenu() => isMenuOpen.value = !isMenuOpen.value;

  void closeMenu() => isMenuOpen.value = false;

  // ================== منطق التنقل (Scroll Logic) ==================
  Future<void> scrollToSection(GlobalKey key) async {
    // إذا كانت القائمة مفتوحة (في الجوال)، نغلقها أولاً
    if (isMenuOpen.value) {
      closeMenu();
      // انتظار بسيط حتى ينتهي أنيميشن إغلاق القائمة
      await Future.delayed(Duration(milliseconds: 300));
    }

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutQuart,
      );
    }
  }
}