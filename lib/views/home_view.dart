import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../widgets/section_title.dart';
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
import '../widgets/skill_card.dart';
import '../widgets/social_icon.dart';

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
                    SizedBox(height: 50), // مسافة أولية

                    // 1. قسم الهيرو (Hero Section)
                    Container(
                      key: controller.homeKey, // مفتاح الرئيسية
                      child: FadeInUp(
                          delay: 200,
                          child: _buildHeroSection(context)
                      ),
                    ),

                    SizedBox(height: 120), // فاصل كبير

                    // 2. قسم المهارات التقنية (Skills Section)
                    Container(
                      key: controller.skillsKey, // مفتاح المهارات
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                            delay: 300,
                            child: SectionTitle(title: "مهاراتي التقنية"),
                          ),
                          SizedBox(height: 50),
                          FadeInUp(
                            delay: 400,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 180,
                                // أقصى عرض للكرت الواحد
                                childAspectRatio: 1,
                                // نسبة مربع (1:1)
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: controller.skills.length,
                              itemBuilder: (context, index) {
                                return SkillCard(
                                    skill: controller.skills[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 120), // فاصل كبير

                    // 3. قسم المشاريع (Projects Section)
                    Container(
                      key: controller.projectsKey, // مفتاح المشاريع
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                              delay: 400,
                              child: SectionTitle(title: "أحدث أعمالي")
                          ),
                          SizedBox(height: 50),
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
                                // نسبة العرض للطول
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

                    SizedBox(height: 120), // فاصل كبير

                    // 4. قسم الشهادات (Certificates Section)
                    Container(
                      key: controller.certificatesKey, // مفتاح الشهادات
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                              delay: 800,
                              child: SectionTitle(title: "شهاداتي وإنجازاتي")
                          ),

                          SizedBox(height: 50),

                          FadeInUp(
                            delay: 1000,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ResponsiveHelper.isDesktop(
                                    context)
                                    ? 3
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

                    SizedBox(height: 150), // فاصل قبل الفوتر

                    // 5. قسم التواصل / الفوتر (Contact Section)
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
                          SizedBox(height: 30),

                          // ================== صف الأيقونات ==================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialIcon(
                                  icon: FontAwesomeIcons.whatsapp,
                                  url: controller.whatsappUrl
                              ),
                              SizedBox(width: 15),
                              SocialIcon(
                                  icon: FontAwesomeIcons.linkedinIn,
                                  url: controller.linkedinUrl
                              ),
                              SizedBox(width: 15),
                              SocialIcon(
                                  icon: FontAwesomeIcons.github,
                                  url: controller.githubUrl
                              ),
                            ],
                          ),
                          // ===================================================

                          SizedBox(height: 50),
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
      text: "< / >",
      color: AppColors.primary,
      fontSize: 140,
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
                  child: pulsingCodeIcon
              )),
        ],
      ),
      tablet: Column(
        children: [
          pulsingCodeIcon,
          SizedBox(height: 30),
          _heroContent(context, centerAlign: true),
        ],
      ),
      mobile: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PulsingText(
              text: "< / >",
              color: AppColors.primary,
              fontSize: 100
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
              controller.scrollToSection(controller.contactKey);
            },
          ),
        ],
      ),
    );
  }
}