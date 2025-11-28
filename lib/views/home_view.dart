import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_website/widgets/section_title.dart';
import '../controllers/home_controller.dart';
import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';
import '../widgets/certificate_card.dart';
import '../widgets/nav_bar.dart';
import '../widgets/project_card.dart';
import '../widgets/glowing_button.dart';
import '../widgets/fade_in_up.dart';
import '../widgets/modern_background.dart';
import '../widgets/pulsing_text.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // حقن الكنترولر
    Get.put(HomeController());

    return Scaffold(
      body: ModernBackground(
        child: Stack(
          children: [
            // ================== الطبقة الخلفية: المحتوى القابل للتمرير ==================
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 100, // مسافة علوية عشان الناف بار ما يغطي أول المحتوى
                  left: ResponsiveHelper.isDesktop(context) ? 120 : 20,
                  right: ResponsiveHelper.isDesktop(context) ? 120 : 20,
                  bottom: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 120,),
                    // 1. قسم الهيرو (Hero Section)
                    Container(
                      key: controller.homeKey, // مفتاح الرئيسية
                      child: FadeInUp(
                          delay: 200,
                          child: _buildHeroSection(context)
                      ),
                    ),

                    SizedBox(height: 120),

                    // 2. قسم المشاريع (Projects Section)
                    Container(
                      key: controller.projectsKey, // مفتاح المشاريع
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                            delay: 400,
                            child: SectionTitle(title: "احدث اعمالي")
                          ),
                          SizedBox(height: 70),
                          FadeInUp(
                            delay: 600,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ResponsiveHelper.isDesktop(
                                    context)
                                    ? 3 // 3 أعمدة للكمبيوتر
                                    : ResponsiveHelper.isTablet(context)
                                    ? 2
                                    : 1,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 30,
                                // نسبة العرض للطول: 0.65 تجعل الكرت طويلاً ومناسباً للوصف
                                childAspectRatio: ResponsiveHelper.isDesktop(
                                    context)
                                    ? 0.65
                                    : ResponsiveHelper.isTablet(context)
                                    ? 0.70
                                    : 0.85,
                              ),
                              itemCount: controller.projects.length,
                              itemBuilder: (context, index) {
                                return ProjectCard(
                                    project: controller.projects[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 200),

                    // 3. قسم الشهادات (Certificates Section)
                    Container(
                      key: controller.certificatesKey,
                      // مفتاح الشهادات (الجديد)
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                            delay: 800,
                            child: SectionTitle(title: "شهاداتي و إنجازاتي")
                          ),

                          SizedBox(height: 70),

                          FadeInUp(
                            delay: 1000,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ResponsiveHelper.isDesktop(
                                    context)
                                    ? 3 // 3 أعمدة للكمبيوتر
                                    : ResponsiveHelper.isTablet(context)
                                    ? 2
                                    : 1,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 30,
                                childAspectRatio: ResponsiveHelper.isDesktop(
                                    context)
                                    ? 0.65
                                    : ResponsiveHelper.isTablet(context)
                                    ? 0.70
                                    : 0.85,
                              ),
                              itemCount: controller.certificates.length,
                              itemBuilder: (context, index) {
                                return CertificateCard(certificate: controller
                                    .certificates[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 200),

                    // 4. قسم التواصل / الفوتر (Contact Section)
                    Container(
                      key: controller.contactKey, // مفتاح التواصل
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "هل لديك مشروع؟ لنعمل معاً",
                              style: TextStyle(color: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)
                          ),
                          SizedBox(height: 10),
                          Text(
                              "contact@yourmail.com", // ضع ايميلك هنا
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18)
                          ),
                          SizedBox(height: 70),
                          Text(
                              "© 2024 جميع الحقوق محفوظة",
                              style: TextStyle(color: AppColors.textGrey)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ================== الطبقة الأمامية: الناف بار الثابت ==================
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: FadeInUp(delay: 0, child: NavBar()),
            ),
          ],
        ),
      ),
    );
  }

  // ================== الويدجتز المساعدة ==================

  Widget _buildHeroSection(BuildContext context) {
    // نجهز الرمز الذي نريده أن ينبض
    Widget pulsingCodeIcon = PulsingText(
      text: "< / >", // الرمز بدل الأيقونة الجاهزة
      color: AppColors.primary, // اللون المميز (التيل)
      fontSize: 140, // حجم كبير جداً ليناسب الهيرو
    );

    return ResponsiveHelper(
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: _heroContent(context, centerAlign: false)),
          Expanded(
              flex: 1,
              child: Center(
                // استبدلنا Icon(Icons.code...) بهذا الويدجت
                  child: pulsingCodeIcon
              )),
        ],
      ),
      tablet: Column(
        children: [
          // استبدلنا الأيقونة هنا أيضاً
          pulsingCodeIcon,
          SizedBox(height: 30),
          _heroContent(context, centerAlign: true),
        ],
      ),
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // استبدلنا الأيقونة هنا أيضاً (بحجم أصغر قليلاً للجوال إذا أردت)
          PulsingText(
              text: "< / >",
              color: AppColors.primary,
              fontSize: 100 // حجم مناسب للجوال
          ),
          SizedBox(height: 30),
          _heroContent(context, centerAlign: true),
        ],
      ),
    );
  }


  Widget _heroContent(BuildContext context, {bool centerAlign = false}) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment:
        centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisAlignment:
        centerAlign ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(
            "مرحباً، أنا المبرمج والمسوق",
            style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold),
            textAlign: centerAlign ? TextAlign.center : TextAlign.start,
          ),
          SizedBox(height: 10),
          Text(
            "أبني حلولاً برمجية\nتنمي أعمالك.",
            textAlign: centerAlign ? TextAlign.center : TextAlign.start,
            style: TextStyle(
                color: AppColors.textWhite,
                fontSize: ResponsiveHelper.isDesktop(context) ? 50 : 35,
                fontWeight: FontWeight.bold,
                height: 1.2),
          ),
          SizedBox(height: 20),
          Container(
            constraints: BoxConstraints(maxWidth: centerAlign ? 500 : 700),
            child: Text(
              controller.aboutMe,
              textAlign: centerAlign ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                  color: AppColors.textGrey, fontSize: 16, height: 1.6),
            ),
          ),
          SizedBox(height: 30),
          GlowingButton(
            text: "تواصل معي",
            onPressed: () {
              // عند الضغط ينزل لآخر الصفحة (قسم التواصل)
              controller.scrollToSection(controller.contactKey);
            },
          ),
        ],
      ),
    );
  }
}