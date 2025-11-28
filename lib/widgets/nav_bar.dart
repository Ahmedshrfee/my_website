import 'dart:ui'; // لتأثير الزجاج
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';
import '../controllers/home_controller.dart';
import 'glowing_nav_item.dart';

class NavBar extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
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
                    Text("<DevMarketer />",
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
                          _navItemDesktop("الرئيسية", controller.homeKey),
                          SizedBox(width: 30),
                          _navItemDesktop("المشاريع", controller.projectsKey),
                          SizedBox(width: 30),
                          _navItemDesktop("مهاراتي", controller.skillsKey),
                          // <--- الرابط الجديد
                          SizedBox(width: 30),
                          _navItemDesktop(
                              "شهاداتي", controller.certificatesKey),
                          SizedBox(width: 30),
                          _navItemDesktop("اتصل بي", controller.contactKey),

                          SizedBox(width: 40), // مسافة فاصلة للزر

                          // زر السيرة الذاتية
                          _resumeButton(),
                        ],
                      )
                    // 3. زر القائمة للجوال
                    else
                      Obx(() =>
                          IconButton(
                            icon: Icon(
                                controller.isMenuOpen.value
                                    ? Icons.close
                                    : Icons.menu,
                                color: AppColors.textWhite, size: 30
                            ),
                            onPressed: () => controller.toggleMenu(),
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
                        height: controller.isMenuOpen.value ? null : 0,
                        color: AppColors.background.withOpacity(0.85),
                        width: double.infinity,
                        child: controller.isMenuOpen.value
                            ? Column(children: [
                          _navItemMobile("الرئيسية", controller.homeKey),


                          _navItemMobile("المشاريع", controller.projectsKey),
                          _navItemMobile("مهاراتي", controller.skillsKey),
                          _navItemMobile("شهاداتي", controller.certificatesKey),
                          _navItemMobile("اتصل بي", controller.contactKey),

                          SizedBox(height: 15),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _resumeButton(isMobile: true),
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
  Widget _resumeButton({bool isMobile = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // رابط السيرة الذاتية
          String cvUrl = "https://raw.githubusercontent.com/Ahmedshrfee/my_website/refs/heads/master/lib/assets/images/certif1.png";

          // استدعاء دالة التحميل
          controller.downloadFile(cvUrl, filename: "Ahmed_CV.png");

          if (isMobile) controller.closeMenu();
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
  Widget _navItemDesktop(String title, GlobalKey key) {
    return GlowingNavItem(
      text: title,
      onTap: () => controller.scrollToSection(key),
    );
  }

  // عنصر القائمة للجوال
  Widget _navItemMobile(String title, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GlowingNavItem(
        text: title,
        onTap: () => controller.scrollToSection(key),
        isMobile: true,
      ),
    );
  }
}