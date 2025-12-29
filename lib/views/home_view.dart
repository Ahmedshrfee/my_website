import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:my_website/data/personal_info.dart';

// استدعاء الكنترولرات الجديدة
import '../controllers/contact_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/data_controller.dart';
import '../controllers/download_controller.dart';

import '../utils/app_colors.dart';
import '../utils/responsive_helper.dart';
import '../widgets/section_title.dart';
import '../widgets/certificate_card.dart';
import '../widgets/nav_bar.dart';
import '../widgets/project_card.dart';
import '../widgets/glowing_button.dart';
import '../widgets/fade_in_up.dart';
import '../widgets/modern_background.dart';
import '../widgets/pulsing_text.dart';
import '../widgets/skill_card.dart';
import '../widgets/social_icon.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. حقن الكنترولرات الجديدة (Dependency Injection)
    final contactCtrl = Get.put(ContactController());
    final navCtrl = Get.put(navigationController());
    final dataCtrl = Get.put(dataController());
    Get.put(
        downloadController()); // نحقنه ليستخدمه الأبناء (مثل CertificateCard)

    return Scaffold(
      body: ModernBackground(
        child: Stack(
          children: [
            // ================== الطبقة الخلفية: المحتوى القابل للتمرير ==================
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 100,
                  left: ResponsiveHelper.isDesktop(context) ? 120 : 20,
                  right: ResponsiveHelper.isDesktop(context) ? 120 : 20,
                  bottom: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),

                    // 1. قسم الهيرو (Hero Section)
                    Container(
                      key: navCtrl.homeKey, // استخدام navCtrl للمفاتيح
                      child: FadeInUp(
                          delay: 200,
                          child: _buildHeroSection(context, navCtrl, dataCtrl)
                      ),
                    ),

                    SizedBox(height: 120),

                    // 2. قسم المهارات التقنية (Skills Section)
                    Container(
                      key: navCtrl.skillsKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                            delay: 300,
                            child: SectionTitle(title: "مهاراتي التقنية والتسويقية"),
                          ),
                          SizedBox(height: 50),
                          FadeInUp(
                            delay: 400,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 180,
                                childAspectRatio: 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: dataCtrl.skills.length,
                              // استخدام dataCtrl للبيانات
                              itemBuilder: (context, index) {
                                return SkillCard(
                                    skill: dataCtrl.skills[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 120),

                    // 3. قسم المشاريع (Projects Section)
                    Container(
                      key: navCtrl.projectsKey,
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
                              itemCount: dataCtrl.projects.length,
                              // استخدام dataCtrl للبيانات
                              itemBuilder: (context, index) {
                                return ProjectCard(
                                    project: dataCtrl.projects[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 120),

                    // 4. قسم الشهادات (Certificates Section)
                    Container(
                      key: navCtrl.certificatesKey,
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
                              itemCount: dataCtrl.certificates.length,
                              // استخدام dataCtrl للبيانات
                              itemBuilder: (context, index) {
                                return CertificateCard(
                                    certificate: dataCtrl.certificates[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 150),

                    // 5. قسم التواصل / الفوتر (Contact Section)
                    Container(
                      key: navCtrl.contactKey,
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


                          SizedBox(height: 30),
                          Container(
                            width: ResponsiveHelper.isDesktop(context)
                                ? 500
                                : double.infinity, // عرض مناسب
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                // حقل الإيميل
                                TextField(
                                  controller: contactCtrl.emailController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "بريدك الإلكتروني",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.black12,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                  ),
                                ),
                                SizedBox(height: 15),

                                // حقل الرسالة
                                TextField(
                                  controller: contactCtrl.messageController,
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 4, // مساحة أكبر للكتابة
                                  decoration: InputDecoration(
                                    hintText: "اكتب رسالتك هنا...",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.black12,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                  ),
                                ),
                                SizedBox(height: 20),

                                // زر الإرسال
                                Obx(() =>
                                contactCtrl.isLoading.value
                                    ? CircularProgressIndicator(
                                    color: AppColors.primary)
                                    : ElevatedButton(
                                  onPressed: () => contactCtrl.sendMessage(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                  ),
                                  child: Text("إرسال الرسالة", style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                                )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),

                          Text(
                              PersonalInfo.email,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18)
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          // ================== صف الأيقونات ==================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialIcon(
                                icon: FontAwesomeIcons.whatsapp,
                                url: dataCtrl.whatsappUrl, // روابط من dataCtrl
                              ),
                              SizedBox(width: 15),
                              SocialIcon(
                                icon: FontAwesomeIcons.linkedinIn,
                                url: dataCtrl.linkedinUrl,
                              ),
                              SizedBox(width: 15),
                              SocialIcon(
                                icon: FontAwesomeIcons.github,
                                url: dataCtrl.githubUrl,
                              ),
                            ],
                          ),
                          // ===================================================

                          SizedBox(height: 50),
                          Text(
                              "© جميع الحقوق محفوظة لأحمد بوطلعة 2025",
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

  // قمنا بتحديث الدوال لتقبل الكنترولرات كمعاملات (Arguments)
  Widget _buildHeroSection(BuildContext context, navigationController navCtrl,
      dataController dataCtrl) {
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
          Expanded(flex: 2,
              child: _heroContent(
                  context, navCtrl, dataCtrl, centerAlign: false)),
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
          _heroContent(context, navCtrl, dataCtrl, centerAlign: true),
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
          _heroContent(context, navCtrl, dataCtrl, centerAlign: true),
        ],
      ),
    );
  }

  Widget _heroContent(BuildContext context, navigationController navCtrl,
      dataController dataCtrl, {bool centerAlign = false}) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment:
        centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisAlignment:
        centerAlign ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(
            "مرحباً، أنا أحمد بوطلعة",
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
              dataCtrl.aboutMe, // النص من داتا كنترولر
              textAlign: centerAlign ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                  color: AppColors.textGrey, fontSize: 16, height: 1.6),
            ),
          ),
          SizedBox(height: 30),
          GlowingButton(
            text: "تواصل معي",
            onPressed: () {
              // التنقل من نافيقيشن كنترولر
              navCtrl.scrollToSection(navCtrl.contactKey);
            },
          ),
        ],
      ),
    );
  }
}