import 'dart:ui'; // مهمة لتأثير الزجاج (BackdropFilter)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';
import '../controllers/home_controller.dart';
import 'glowing_nav_item.dart'; // استدعاء الويدجت الجديد

class NavBar extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        // زيادة الضبابية لتعطي تأثير الزجاج القوي
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            // جعلنا اللون شفافاً جداً (0.2 بدلاً من 0.7)
            color: AppColors.background.withOpacity(0.2),
            // حدود سفلية بيضاء شبه مخفية للمعة
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

                    // 1. اللوجو (وضعناه أولاً ليظهر على اليمين في اللغة العربية)
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

                    // 2. الروابط أو زر القائمة (ليظهر على اليسار)
                    if (ResponsiveHelper.isDesktop(context))
                      Row(
                        children: [
                          _navItemDesktop("الرئيسية", controller.homeKey),
                          SizedBox(width: 30),
                          _navItemDesktop("المشاريع", controller.projectsKey),
                          SizedBox(width: 30),

                          _navItemDesktop(
                              "شهاداتي", controller.certificatesKey),
                          SizedBox(width: 30),
                          _navItemDesktop("اتصل بي", controller.contactKey),
                        ],
                      )
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

              // القائمة المنسدلة للجوال (شفافة أيضاً)
              if (!ResponsiveHelper.isDesktop(context))
                Obx(() =>
                    AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        height: controller.isMenuOpen.value ? null : 0,
                        // لون أغمق قليلاً للقائمة المنسدلة لضمان قراءة النصوص
                        color: AppColors.background.withOpacity(0.85),
                        width: double.infinity,
                        child: controller.isMenuOpen.value
                            ? Column(children: [
                          _navItemMobile("الرئيسية", controller.homeKey),
                          _navItemMobile("المشاريع", controller.projectsKey),
                          _navItemMobile("شهاداتي", controller.projectsKey),

                          _navItemMobile("اتصل بي", controller.contactKey),

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

  // استخدام الويدجت الجديد للكمبيوتر (تم التحديث لقبول Key)
  Widget _navItemDesktop(String title, GlobalKey key) {
    return GlowingNavItem(
      text: title,
      onTap: () {
        controller.scrollToSection(key);
      },
    );
  }

  // استخدام الويدجت الجديد للجوال (تم التحديث لقبول Key)
  Widget _navItemMobile(String title, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GlowingNavItem(
        text: title,
        onTap: () {
          // دالة السكرول في الكنترولر تغلق القائمة تلقائياً
          controller.scrollToSection(key);
        },
        isMobile: true, // لتكبير الخط قليلاً
      ),
    );
  }
}