import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // لجلب بيانات الملف
import 'dart:html' as html; // مكتبة الويب للتحميل

import '../models/project_model.dart';
import '../models/certificate_model.dart';

class HomeController extends GetxController {

  // ================== مفاتيح الأقسام (Smooth Scroll) ==================
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey certificatesKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  // ================== متغيرات الحالة ==================
  var isMenuOpen = false.obs;

  // ================== البيانات ==================

  final String aboutMe = "مطور تطبيقات ومسوق إلكتروني شغوف بتحويل الأفكار إلى واقع رقمي ملموس. أجمع بين القوة البرمجية وفن الوصول للجمهور.";

  // قائمة المشاريع
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

  // قائمة الشهادات (تمت استعادتها 3 شهادات)
  final List<CertificateModel> certificates = [
    CertificateModel(
      title: "Flutter Intern",
      description: "دورة شاملة تغطي أساسيات تحليل البيانات، استخدام لغة R، وبرامج SQL، بالإضافة إلى التصوير البياني للبيانات.",
      imagePath: "lib/assets/images/flutterPracticeCertf.jpg",
      // تأكد من وجود الصور في مجلد assets
      downloadUrl: "https://raw.githubusercontent.com/Ahmedshrfee/my_website/refs/heads/master/lib/assets/images/flutterPracticeCertf.jpg",
    ),
    CertificateModel(
      title: "مبادئ فن التواصل",
      description: "كورس متقدم في بناء تطبيقات فلاتر مع التركيز على هندسة البرمجيات وإدارة الحالة باستخدام GetX و Provider.",
      imagePath: "lib/assets/images/contactCertf.png",
      // غير اسم الصورة اذا عندك صور مختلفة
      downloadUrl: "https://raw.githubusercontent.com/Ahmedshrfee/my_website/refs/heads/master/lib/assets/images/contactCertf.png",
    ),
    CertificateModel(
      title: "Digital Marketing Pro",
      description: "شهادة احترافية في التسويق الرقمي تشمل إدارة الحملات الإعلانية، تحسين محركات البحث (SEO)، وتحليل السوق.",
      imagePath: "assets/images/certif1.png",
      downloadUrl: "https://raw.githubusercontent.com/Ahmedshrfee/my_website/refs/heads/master/lib/assets/images/certif1.png",
    ),
  ];

  // ================== الدوال المنطقية ==================

  void toggleMenu() => isMenuOpen.value = !isMenuOpen.value;

  void closeMenu() => isMenuOpen.value = false;

  // 1. دالة التنقل الانسيابي
  Future<void> scrollToSection(GlobalKey key) async {
    if (isMenuOpen.value) {
      closeMenu();
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

  // 2. دالة تحميل الملفات (Force Download) للويب
  void downloadFile(String url, {String filename = "file.png"}) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final blob = html.Blob([response.bodyBytes]);
        final urlBlob = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: urlBlob)
          ..setAttribute("download", filename)
          ..click();
        html.Url.revokeObjectUrl(urlBlob);
      } else {
        Get.snackbar("تنبيه", "فشل الوصول للملف");
      }
    } catch (e) {
      html.window.open(url, "_blank");
    }
  }

  // دالة تحميل الـ CV (تستدعي دالة التحميل العامة)
  void downloadCV() {
    downloadFile(
        "https://raw.githubusercontent.com/Ahmedshrfee/my_website/refs/heads/master/lib/assets/images/certif1.png",
        filename: "Ahmed_CV.png"
    );
  }
}