import 'dart:ui'; // لتأثير الزجاج
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';

// استدعاء الكنترولرات الجديدة
import '../controllers/navigation_controller.dart';
import '../controllers/download_controller.dart';
import 'glowing_nav_item.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // الوصول للكنترولرات المحقونة في HomeView
    final navCtrl = Get.find<navigationController>();
    final downCtrl = Get.find<downloadController>();

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.2),
            border: Border(bottom: BorderSide(
                color: Colors.white.withOpacity(0.1), width: 0.5)),
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // 1. اللوجو (على اليمين في العربي)
                    Text("Ahmed Butalah",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [BoxShadow(color: AppColors.primary
                              .withOpacity(0.5), blurRadius: 15)
                          ],
                        )
                    ),

                    // 2. الروابط + زر السيرة الذاتية (على اليسار)
                    if (ResponsiveHelper.isDesktop(context))
                      Row(
                        children: [
                          _navItemDesktop("الرئيسية", navCtrl.homeKey, navCtrl),
                          SizedBox(width: 30),
                          _navItemDesktop(
                              "المشاريع", navCtrl.projectsKey, navCtrl),
                          SizedBox(width: 30),
                          _navItemDesktop(
                              "مهاراتي", navCtrl.skillsKey, navCtrl),
                          SizedBox(width: 30),
                          _navItemDesktop(
                              "شهاداتي", navCtrl.certificatesKey, navCtrl),
                          SizedBox(width: 30),
                          _navItemDesktop(
                              "اتصل بي", navCtrl.contactKey, navCtrl),

                          SizedBox(width: 40), // مسافة فاصلة للزر

                          // زر السيرة الذاتية
                          _resumeButton(downCtrl),
                        ],
                      )
                    // 3. زر القائمة للجوال
                    else
                      Obx(() =>
                          IconButton(
                            icon: Icon(
                                navCtrl.isMenuOpen.value
                                    ? Icons.close
                                    : Icons.menu,
                                color: AppColors.textWhite, size: 30
                            ),
                            onPressed: () => navCtrl.toggleMenu(),
                          )),
                  ],
                ),
              ),

              // القائمة المنسدلة للجوال
              if (!ResponsiveHelper.isDesktop(context))
                Obx(() =>
                    AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        height: navCtrl.isMenuOpen.value ? null : 0,
                        color: AppColors.background.withOpacity(0.85),
                        width: double.infinity,
                        child: navCtrl.isMenuOpen.value
                            ? Column(children: [
                          _navItemMobile("الرئيسية", navCtrl.homeKey, navCtrl),
                          _navItemMobile("المشاريع", navCtrl.projectsKey,
                              navCtrl),
                          _navItemMobile("مهاراتي", navCtrl.skillsKey, navCtrl),
                          _navItemMobile("شهاداتي", navCtrl.certificatesKey,
                              navCtrl),
                          _navItemMobile("اتصل بي", navCtrl.contactKey,
                              navCtrl),

                          SizedBox(height: 15),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _resumeButton(
                                downCtrl, isMobile: true, navCtrl: navCtrl),
                          ),
                        ])
                            : SizedBox(),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  // --- زر السيرة الذاتية ---
  Widget _resumeButton(downloadController downCtrl,
      {bool isMobile = false, navigationController? navCtrl}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // استدعاء دالة التحميل من الكنترولر الجديد
          downCtrl.downloadCV();

          if (isMobile && navCtrl != null) navCtrl.closeMenu();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: isMobile ? 12 : 8
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            border: Border.all(color: AppColors.primary, width: 1.5),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.download_rounded, color: AppColors.primary, size: 18),
              SizedBox(width: 8),
              Text(
                "سيرتي الذاتية",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // عنصر القائمة للكمبيوتر
  Widget _navItemDesktop(String title, GlobalKey key,
      navigationController navCtrl) {
    return GlowingNavItem(
      text: title,
      onTap: () => navCtrl.scrollToSection(key),
    );
  }

  // عنصر القائمة للجوال
  Widget _navItemMobile(String title, GlobalKey key,
      navigationController navCtrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GlowingNavItem(
        text: title,
        onTap: () => navCtrl.scrollToSection(key),
        isMobile: true,
      ),
    );
  }
}