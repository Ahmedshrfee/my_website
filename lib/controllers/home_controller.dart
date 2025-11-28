import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/certificate_model.dart';
import '../models/project_model.dart';

class HomeController extends GetxController {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey certificatesKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey(); // لقسم اتصل بي

  var isMenuOpen = false.obs;

  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
  }

  void closeMenu() {
    isMenuOpen.value = false;
  }
  // بيانات نبذة عني
  final String aboutMe = "مطور تطبيقات ومسوق إلكتروني شغوف بتحويل الأفكار إلى واقع رقمي ملموس. أجمع بين القوة البرمجية وفن الوصول للجمهور.";

// قائمة الشهادات
  final List<CertificateModel> certificates = [

    CertificateModel(
      title: "Google Data Analytics Certificate",
      description: "دورة شاملة تغطي أساسيات تحليل البيانات، استخدام لغة R، وبرامج SQL، بالإضافة إلى التصوير البياني للبيانات.",
      // وصف طويل
      imagePath: "lib/assets/images/certif1.png",
      downloadUrl: "...",
    ),
    CertificateModel(
      title: "Google Data Analytics Certificate",
      description: "دورة شاملة تغطي أساسيات تحليل البيانات، استخدام لغة R، وبرامج SQL، بالإضافة إلى التصوير البياني للبيانات.",
      // وصف طويل
      imagePath: "lib/assets/images/certif1.png",
      downloadUrl: "...",
    ),
    CertificateModel(
      title: "Google Data Analytics Certificate",
      description: "دورة شاملة تغطي أساسيات تحليل البيانات، استخدام لغة R، وبرامج SQL، بالإضافة إلى التصوير البياني للبيانات.",
      // وصف طويل
      imagePath: "lib/assets/images/certif1.png",
      downloadUrl: "...",
    ),];
  // قائمة المشاريع (تستطيع جلبها من API لاحقاً)
  final List<ProjectModel> projects = [
    ProjectModel(title: "متجر إلكتروني متكامل",
        description: "تطبيق تجارة إلكترونية يدعم الدفع والخرائط.",
        techStack: "Flutter, Firebase"),
    ProjectModel(title: "نظام إدارة مهام",
        description: "لوحة تحكم لإدارة فرق العمل والإنتاجية.",
        techStack: "Flutter Web, GetX"),
    ProjectModel(title: "حملة تسويقية عقارية",
        description: "صفحة هبوط حققت نسبة تحويل 15%.",
        techStack: "SEO, Google Ads"),
  ];

  Future<void> scrollToSection(GlobalKey key) async {
    // إذا كانت القائمة مفتوحة (في الجوال)، نغلقها أولاً
    if (isMenuOpen.value) {
      closeMenu();
      // انتظار بسيط جداً عشان القائمة تختفي قبل ما يبدأ السكرول
      await Future.delayed(Duration(milliseconds: 300));
    }

    // أمر التمرير
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(seconds: 1), // مدة الحركة (ثانية واحدة)
        curve: Curves.easeInOutQuart, // شكل الحركة (بداية بطيئة ونهاية بطيئة)
      );
    }
  }


  // دالة لفتح الروابط (Logic)
  void launchURL(String url) async {
    // استخدم url_launcher هنا
  }
}